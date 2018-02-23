#!/bin/bash
set -e

if [[ -e /www/.env && "$APP_ENV_BASE64" != "" && "$(cat /www/.env)" != "$(echo \"$APP_ENV_BASE64\" | base64 -d)" ]]; then
    echo "WARNING: Environment variable APP_ENV_BASE64 doesn't match the persisted /www/.env version. This is either because you are trying to use both the environment variable and the mounted file version, or because you changed the environment."
    echo ""
    echo "Updating /www/.env"
fi

if [ "$APP_ENV_BASE64" != "" ]; then
    if [ -L "$APP_ENV_FILE" ]; then
        rm -f $APP_ENV_FILE
    fi
    echo "$APP_ENV_BASE64" | base64 -d > /www/.env
    echo "" >> /www/.env
fi

if [[ ! -e /www/.env ]]; then
    ln -s $APP_ENV_FILE .env
fi
