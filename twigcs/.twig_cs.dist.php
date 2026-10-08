<?php

declare(strict_types=1);

use FriendsOfTwig\Twigcs\Config\Config;
use FriendsOfTwig\Twigcs\TemplateResolver\FileResolver;

return Config::create()
    ->setTemplateResolver(new FileResolver(getcwd() . '/templates'));
