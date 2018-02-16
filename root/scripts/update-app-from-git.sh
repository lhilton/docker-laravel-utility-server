#!/bin/bash
set -e

cd /www
git reset --hard HEAD
git pull

if [ ! -e /www/.env ]]; then
    ln -s $APP_ENV_FILE .env
fi

composer install
php artisan migrate
