#!/bin/bash
set -e

if [ "$GIT_AUTO_UPDATE" == "" ]; then
    GIT_AUTO_UPDATE="no"
fi

if [ "$GIT_AUTO_UPDATE_INTERVAL" == "" ]; then
    GIT_AUTO_UPDATE_INTERVAL="5"
fi

if [ "$GIT_AUTO_UPDATE" == "yes" ]; then
    while [[ "forever" == "forever" ]]
    do
        STATUS="$(git -C /www fetch && git -C /www status -uno | sed 's/\s/-/g' | grep 'Your-branch-is-up-to-date-with' | wc -l | tr -d '[:space:]')"
        if [ "$STATUS" -lt "1" ]; then
            /root/scripts/update-app-from-git.sh
        fi

        sleep $GIT_AUTO_UPDATE_INTERVAL
    done
fi
