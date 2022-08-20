<?php

namespace S3DB\Sync;

use Monolog\Logger;

abstract class AbstractSyncer
{
    public function __construct(
        protected Logger $logger
    ) {
    }

    abstract public function push();

    abstract public function pull();

    public function uploadToS3(): void
    {
    }
}
