#!/bin/bash
set -e

BIN=$(which mysqld)
SHOW=$(which mysqlshow)

$BIN &

COUNT=0
while [[ "$(ps aux | grep $BIN | grep -v grep | wc -l | tr -d '[:space:]')" -lt "1" ]]
do
    echo "Waiting for mysqld pid to start..."
    sleep 1
    COUNT=$(expr $COUNT + 1)
    if [ "$COUNT" -eq 5 ]; then
        echo "ERROR: mysqld pid never came online. Aborting."
        exit 10
    fi
done

echo "Mysqld pid started..."

COUNT=0
while [[ $($SHOW --user=$MYSQL_USER --password=$MYSQL_PASSWORD $MYSQL_DATABASE| grep -v Wildcard | grep -o $MYSQL_DATABASE) != "$MYSQL_DATABASE" ]]
do
    echo "Waiting for mysqld to become responsive to start..."
    sleep 1
    COUNT=$(expr $COUNT + 1)
    if [ "$COUNT" -eq 5 ]; then
        echo "ERROR: mysqld never became responsive. Aborting."
        exit 11
    fi
done

echo "Mysqld is responsive..."
