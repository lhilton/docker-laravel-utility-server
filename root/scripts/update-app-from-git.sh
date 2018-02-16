#!/bin/bash
set -e

cd /www
git reset --hard HEAD
git pull
composer install
php artisan migrate
