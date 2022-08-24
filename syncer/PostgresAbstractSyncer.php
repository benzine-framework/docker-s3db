<?php

namespace S3DB\Sync;

use Rych\ByteSize\ByteSize;
use Spatie\Emoji\Emoji;

class PostgresAbstractSyncer extends AbstractSyncer
{
    public function push(): void
    {
        // Dump file from Postgres
        $dumpFile = 'dump.sql';
        $command = sprintf('PG_PASSWORD=$POSTGRESS_PASSWORD pg_dump -U $POSTGRES_USER --clean --inserts > /dumps/%s', $dumpFile);
        passthru($command);

        // Verify the dump worked
        if (!$this->localFilesystem->fileExists($dumpFile)) {
            $this->logger->critical('Database dump failed');

            exit;
        }
        $this->logger->debug(sprintf(
            'Dump file was made, and is %s uncompressed',
            ByteSize::formatMetric(
                $this->localFilesystem->fileSize($dumpFile)
            )
        ));

        // Checksum dump and don't upload if the checksum is the same as last time.
        $hash = sha1_file("/dumps/{$dumpFile}");
        if ($this->localFilesystem->has('previous_hash') && $hash == $this->localFilesystem->read('previous_hash')) {
            $this->logger->debug(sprintf(
                '%s Dump of %s matches previous dump (%s), not uploading the same file again.',
                Emoji::abacus(),
                $dumpFile,
                substr($hash, 0, 7)
            ));

            exit;
        }
        $this->localFilesystem->write('previous_hash', $hash);

        // XZ compress dump
        $compressedDumpFile = $this->compress($dumpFile);

        // Upload
        $storageFile = sprintf('s3db-%s.sql.xz', date('Ymd-His'));
        $this->upload($storageFile, $compressedDumpFile);

        // Cleanup
        $this->cleanup([$compressedDumpFile]);
    }

    public function pull(): void
    {
        // Download latest dumpfile
        $localDownloadedFile = $this->download();

        // Decompress
        $localDecompressedFile = $this->decompress($localDownloadedFile);

        // Push into postgres
        $startImport = microtime(true);
        $command = sprintf('PG_PASSWORD=$POSTGRESS_PASSWORD psql -U $POSTGRES_USER --quiet < /dumps/%s', $localDecompressedFile);
        exec($command);
        $this->logger->info(sprintf(
            '%s Imported %s to postgres in %s seconds',
            Emoji::accordion(),
            $localDecompressedFile,
            number_format(microtime(true) - $startImport, 3)
        ));

        // Cleanup
        $this->cleanup([$localDecompressedFile]);
    }
}
