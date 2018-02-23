#!/bin/bash
set -e

UPDATE_WWW_ENV=/root/scripts/update-www-env.sh

cd /www
git reset --hard HEAD
git pull

$UPDATE_WWW_ENV

composer install
php artisan migrate --force
