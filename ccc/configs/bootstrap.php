<?php

use Symfony\Component\Dotenv\Dotenv;

if (file_exists('/app/vendor/autoload.php')) {
    require '/app/vendor/autoload.php';
}

DG\BypassFinals::enable();

if (method_exists(Dotenv::class, 'bootEnv')) {
    (new Dotenv())->bootEnv('/app/.env');
}
