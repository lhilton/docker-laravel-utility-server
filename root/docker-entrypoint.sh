#!/bin/bash
set -e

UPDATE_WWW_ENV=/root/scripts/update-www-env.sh
UPDATE_GIT_SSH_KEY=/root/scripts/update-git-ssh-key.sh
SETUP_LARAVEL_SCRIPT=/root/scripts/setup-laravel.sh
SETUP_MYSQL_SCRIPT=/root/scripts/setup-mysql.sh

$UPDATE_GIT_SSH_KEY
chmod -R 0600 ~/.ssh

if [ -d /www/.git ]; then
    $UPDATE_WWW_ENV
fi

if [ ! -f /mysql/.created ]; then
    echo 'Running one-time MySQL setup.'
    $SETUP_MYSQL_SCRIPT
fi

if [ ! -d /www/.git ]; then
    echo 'Running one-time App setup script.'
    $SETUP_LARAVEL_SCRIPT
fi

echo ""
echo ""
echo ""
echo ""
echo "****************************************"
echo "****************************************"
echo "**                                    **"
echo "**      Finished container init!      **"
echo "**                                    **"
echo "****************************************"
echo "****************************************"
echo ""
echo ""
echo ""
echo ""

exec /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
