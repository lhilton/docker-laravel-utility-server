#!/bin/bash
set -e

UPDATE_GIT_SSH_KEY=/root/scripts/update-git-ssh-key.sh
SETUP_LARAVEL_SCRIPT=/root/scripts/setup-laravel.sh
SETUP_MYSQL_SCRIPT=/root/scripts/setup-mysql.sh

$UPDATE_GIT_SSH_KEY

chmod -R 0600 ~/.ssh

if [ ! -x /mysql/.created ]; then
    echo 'Running one-time MySQL setup.'
    $SETUP_MYSQL_SCRIPT
fi

if [ ! -d /www/.git ]; then
    echo 'Running one-time App setup script.'
    $SETUP_LARAVEL_SCRIPT
fi

exec /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
