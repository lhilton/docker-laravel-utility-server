#!/bin/bash
set -e

if [[ -e /root/.ssh/id_rsa && "$GIT_SSH_KEY" != "" && "$(cat /root/.ssh/id_rsa)" != "$(echo \"$GIT_SSH_KEY\" | base64 -d)" ]]; then
    echo "ERROR: Environment variable GIT_SSH_KEY doesn't match the persisted /root/.ssh/id_rsa version. This is either because you are trying to use both the environment variable and the mounted file version, or because you changed the key."
    echo ""
    echo "Halting the container"
    exit 6
fi

if [ "$GIT_SSH_KEY" != "" ]; then
    mkdir -p ~/.ssh
    echo "$GIT_SSH_KEY" | base64 -d > ~/.ssh/id_rsa
    echo "" >> ~/.ssh/id_rsa
fi
