<?php

namespace S3DB\Sync;

use League\Flysystem\FileAttributes;
use Monolog\Logger;
use Rych\ByteSize\ByteSize;
use S3DB\Sync\Filesystems\LocalFilesystem;
use S3DB\Sync\Filesystems\StorageFilesystem;
use Spatie\Emoji\Emoji;
use Westsworld\TimeAgo;

abstract class AbstractSyncer
{
    public function __construct(
        protected Logger $logger,
        protected StorageFilesystem $storageFilesystem,
        protected LocalFilesystem $localFilesystem
    ) {
    }

    abstract public function push();

    abstract public function pull();

    protected function download(): string
    {
        $filesInS3 = $this->storageFilesystem->listContents('/')->toArray();
        usort($filesInS3, function (FileAttributes $a, FileAttributes $b) {
            return $a->lastModified() < $b->lastModified();
        });

        /** @var FileAttributes $file */
        foreach ($filesInS3 as $file) {
            $this->logger->debug(sprintf(
                '%s Found %s. It is %s and was created %s',
                Emoji::magnifyingGlassTiltedLeft(),
                $file->path(),
                ByteSize::formatMetric(
                    $file->fileSize()
                ),
                (new TimeAgo())->inWords((new \DateTime())->setTimestamp($file->lastModified()))
            ));
        }

        // Choose which we're downloadin'
        $latest = $filesInS3[0];
        $this->logger->debug(sprintf(
            '%s  Selecting %s... Downloading %s...',
            Emoji::downArrow(),
            $latest->path(),
            ByteSize::formatMetric($latest->fileSize())
        ));

        $localDownloadedFile = basename($latest->path());
        $this->localFilesystem->writeStream(
            $localDownloadedFile,
            $this->storageFilesystem->readStream(
                $latest->path()
            )
        );

        return $localDownloadedFile;
    }
    protected function upload(string $remoteStorageFile, string $localCompressedDumpFile): void
    {
        $startUpload = microtime(true);
        $this->storageFilesystem->writeStream(
            $remoteStorageFile,
            $this->localFilesystem->readStream($localCompressedDumpFile)
        );
        $this->logger->info(sprintf(
            'Uploaded %s as %s to S3 in %s seconds',
            $localCompressedDumpFile,
            $remoteStorageFile,
            number_format(microtime(true) - $startUpload, 3)
        ));
    }

    protected function cleanup(array $files): void
    {
        $cumulativeBytes = 0;
        foreach ($files as $file) {
            $cumulativeBytes += $this->localFilesystem->fileSize($file);
            $this->localFilesystem->delete($file);
        }
        $this->logger->debug(sprintf(
            '%s  Cleanup: Deleted %d files, freed %s',
            Emoji::wastebasket(),
            count($files),
            ByteSize::formatMetric($cumulativeBytes)
        ));
    }

    protected function compress(string $file): string
    {
        $startCompression = microtime(true);
        passthru(sprintf('xz -f -T0 -6 /dumps/%s', $file));
        $compressedFile = "{$file}.xz";
        $this->logger->debug(sprintf(
            '%s Dump file was made, and is %s compressed in %s seconds',
            Emoji::computerDisk(),
            ByteSize::formatMetric(
                $this->localFilesystem->fileSize($compressedFile)
            ),
            number_format(microtime(true) - $startCompression, 3)
        ));

        return $compressedFile;
    }

    protected function decompress(string $compressedFile): string
    {
        $startDecompression = microtime(true);
        if (!substr($compressedFile, -3, 3) == '.xz') {
            $this->logger->critical(sprintf(
                '%s Compressed file %s does not end in .xz',
                Emoji::explodingHead(),
                $compressedFile
            ));

            exit;
        }
        $uncompressedFile = substr($compressedFile, 0, -3);
        passthru(sprintf('xz -d -f /dumps/%s', $compressedFile));

        $this->logger->debug(sprintf(
            '%s Dump file %s was uncompressed from %s to %s in %s seconds',
            Emoji::computerDisk(),
            $uncompressedFile,
            ByteSize::formatMetric($this->storageFilesystem->fileSize($compressedFile)),
            ByteSize::formatMetric($this->localFilesystem->fileSize($uncompressedFile)),
            number_format(microtime(true) - $startDecompression, 3)
        ));

        return $uncompressedFile;
    }
}
