# syntax=docker/dockerfile:1

FROM php:8.3-apache

ENV COMPOSER_ALLOW_SUPERUSER=1
ENV PHP_MEMORY_LIMIT=512M

RUN echo '[*] Updating repo list ...' \
    && apt-get update

RUN echo '[*] Installing system packages git, ssh, gpg, libicu-dev, libzip-dev, unzip, libxslt-dev ...' \
    && apt-get install -qy git ssh gpg libicu-dev libzip-dev unzip libxslt-dev

RUN echo '[*] Installing NodeJS ...' \
    && apt-get install -y nodejs npm

RUN echo '[*] Installing PHP extensions intl, zip, bcmath ...' \
    && docker-php-ext-install intl zip bcmath

RUN echo '[*] Installing Xdebug ...' \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

RUN echo '[*] Installing PCOV ...' \
    && pecl install pcov \
    && docker-php-ext-enable pcov

RUN echo '[*] Installing Composer ...' \
    && php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer

RUN echo '[*] Installing wget ...' \
    && apt-get install -y wget

RUN echo '[*] Cleanup apt ...' \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN echo '[*] INSTALL CCC tools'
RUN mkdir /ccc
COPY ccc/ /ccc
RUN chmod 777 /ccc/scripts/*

RUN echo '[*] INSTALL php-cs-fixer' \
    && wget https://cs.symfony.com/download/php-cs-fixer-v3.phar -O php-cs-fixer \
    && chmod a+x php-cs-fixer \
    && mv php-cs-fixer /usr/local/bin/php-cs-fixer

RUN echo '[*] INSTALL phpcpd' \
    && wget https://phar.phpunit.de/phpcpd.phar -O phpcpd \
    && chmod a+x phpcpd \
    && mv phpcpd /usr/local/bin/phpcpd

RUN echo '[*] INSTALL PHPMD' \
    && wget https://phpmd.org/static/latest/phpmd.phar -O phpmd \
    && chmod a+x phpmd \
    && mv phpmd /usr/local/bin/phpmd

RUN echo '[*] INSTALL PHPLOC' \
    && wget https://phar.phpunit.de/phploc.phar -O phploc \
    && chmod a+x phploc \
    && mv phploc /usr/local/bin/phploc

RUN echo '[*] INSTALL DEPHPEND' \
    && wget https://github.com/mihaeu/dephpend/releases/download/0.8.0/dephpend-0.8.0.phar -O dephpend \
    && chmod a+x dephpend \
    && mv dephpend /usr/local/bin/dephpend

RUN echo '[*] INSTALL INFECTION' \
    && wget https://github.com/infection/infection/releases/download/0.28.1/infection.phar -O infection \
    && chmod a+x infection \
    && mv infection /usr/local/bin/infection

RUN echo '[*] INSTALL phpstan' \
    && composer install --working-dir=/ccc/tools/phpstan

RUN echo '[*] INSTALL phpmetrics' \
    && composer install --working-dir=/ccc/tools/phpmetrics

RUN echo '[*] INSTALL psalm' \
    && composer install --working-dir=/ccc/tools/psalm

RUN echo '[*] INSTALL rector' \
    && composer install --working-dir=/ccc/tools/rector

RUN echo '[*] INSTALL phpunit' \
    && wget -O phpunit.phar https://phar.phpunit.de/phpunit-10.phar \
    && chmod +x phpunit.phar \
    && mv phpunit.phar /usr/local/bin/phpunit

RUN echo '[*] INSTALL EXAKAT' \
    && wget -O exakat.phar https://www.exakat.io/versions/index.php?file=latest \
    && chmod +x exakat.phar \
    && mv exakat.phar /usr/local/bin/exakat

RUN echo '[*] Prepare executable files' \
    && chmod +x /ccc/pipeline \
    && chmod +x /ccc/check \
    && chmod +x /ccc/tests \
    && chmod +x /ccc/fix

RUN echo '[*] Prepare E2E tests executable' \
    && chmod +x /ccc/tools/ccc-e2e/e2e \
    && cp /ccc/tools/ccc-e2e/e2e /usr/local/bin/e2e