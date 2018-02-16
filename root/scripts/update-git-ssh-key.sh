#!/bin/bash
set -e

if [[ -e /root/.ssh/id_rsa && "$GIT_SSH_KEY" != "" ]]; then
    echo "ERROR: You cannot specify a GIT_SSH_KEY environment variable AND mount the /root/.ssh/id_rsa conainer file at the same time."
    exit 6
fi

if [ "$GIT_SSH_KEY" != "" ]; then
    mkdir -p ~/.ssh
    echo "$GIT_SSH_KEY" | base64 -d > ~/.ssh/id_rsa
    echo "" >> ~/.ssh/id_rsa
fi
