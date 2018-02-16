#!/bin/bash
set -e

/root/scripts/mysql-start.sh

git clone $GIT_REPO /www
chown -R www-data:www-data /www
pushd /www
ln -s env.local .env

/root/scripts/update-app-from-git.sh

php artisan db:seed

/root/scripts/mysql-stop.sh
