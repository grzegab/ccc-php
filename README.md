# CCC PHP
Clean Code Container by GrzeGab [http://grzegab.eu](www.grzegab.eu).

This toolkit offers a range of tools for code inspection. It can be integrated with Git hooks to verify everything is functioning correctly in the development environment before pushing changes.

The tools can be utilized independently or as part of a script.

Additionally, there exists a web interface for viewing detailed code descriptions and statistics. This allows for real-time error detection while working.

Difference between local (check and fix, as many as one can) and CI/CD (only check, not all tools)

### Installation
Add declaration to docker compose. use `src` as directory with source files and `tests` as dir 
with unit/integration test files.

```docker
    ccc-php:
        image: grzegab/ccc-php:0.1.2
        volumes:
            - '.:/app'
```
## Usage
### Local testing
* To check code run: `docker compose run --rm ccc-php /ccc/check`
* To fix code run `docker compose run --rm ccc-php /ccc/fix`

### Pipelines
This container can be used in pipelines. Just insert image in docker-compose and run command: `docker compose run --rm ccc-php /ccc/check`

## Tools used
* PHP CS-Fixer [https://github.com/PHP-CS-Fixer/PHP-CS-Fixer](https://github.com/PHP-CS-Fixer/PHP-CS-Fixer)
* PHP Stan [https://phpstan.org](https://phpstan.org)
* Rector [https://github.com/rectorphp/rector](https://github.com/rectorphp/rector)

## TBD
* Reports available on website (for the momemnt there is nothing to report nor website is running) - unit test, coverage etc.
* Add PHP MD
* ADD Infection tests (https://infection.github.io/guide/usage.html)
* Make E2E tests working here (based on documentation + config files)
* Add PHP CPD (Copy paste detect)
* Add PHPLOC
* Add PHPMETRICS
* Add code reviews by AI
* Add documentation validator (check if documentation has no errors without running endpoints)

## Initial work
Greg, Lord of Mailgun Messages, Master of Redis Realms, Messenger of Symfony Secrets, Champion of Domain-Driven Development, Guardian of PHPUnit Proclamations, and Sage of PHP Sorcery
