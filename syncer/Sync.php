<?php

namespace S3DB\Sync;

use Bramus\Monolog\Formatter\ColoredLineFormatter;
use Garden\Cli\Args;
use Garden\Cli\Cli;
use Monolog\Handler\StreamHandler;
use Monolog\Logger;
use Spatie\Emoji\Emoji;

class Sync
{
    protected Logger $logger;
    protected Cli $cli;
    protected Args $args;
    protected AbstractSyncer $syncer;

    public function __construct(
    ) {
        $environment = array_merge($_ENV, $_SERVER);
        ksort($environment);

        $this->cli = new Cli();
        $this->cli->opt('postgres', 'postgres mode')
            ->opt('mysql', 'mysql mode')
            ->opt('push', 'push to s3')
            ->opt('pull', 'pull from s3')
        ;
        $this->args = $this->cli->parse($environment['argv'], true);

        $this->logger = new Logger('syncer');
        $this->logger->pushHandler(new StreamHandler('/var/log/syncer.log', Logger::DEBUG));
        $stdout = new StreamHandler('php://stdout', Logger::DEBUG);
        $stdout->setFormatter(new ColoredLineFormatter(null, "%level_name%: %message% \n"));
        $this->logger->pushHandler($stdout);

        if ($this->args->hasOpt('postgres')) {
            $this->logger->debug(sprintf('%s  Starting in postgres mode', Emoji::CHARACTER_HOURGLASS_NOT_DONE));
            $this->syncer = new PostgresAbstractSyncer($this->logger);
        } elseif ($this->args->hasOpt('mysql')) {
            $this->logger->debug(sprintf('%s  Starting in mysql mode', Emoji::CHARACTER_HOURGLASS_NOT_DONE));

            exit('Not implemented yet');
        } else {
            $this->logger->critical(sprintf('%s Must be started in either --mysql or --postgres mode!', Emoji::CHARACTER_NERD_FACE));

            exit;
        }
    }

    public function run(): void
    {
        if ($this->args->hasOpt('push')) {
            $this->logger->debug(sprintf('%s Running push', Emoji::upArrow()));
            $this->syncer->push();
        } elseif ($this->args->hasOpt('pull')) {
            $this->logger->debug(sprintf('%s Running pull', Emoji::downArrow()));
            $this->syncer->pull();
        } else {
            $this->logger->critical(sprintf('%s Must be run in either --push or --pull mode!', Emoji::CHARACTER_NERD_FACE));

            exit;
        }
    }
}
