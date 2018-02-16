#!/bin/bash
set -e

BIN=$(which mysqld)

PID=$(ps -ef | grep $BIN | grep -v grep | awk '{print $1}')

if [ "$PID" != "" ]; then
    echo "Killing mysqld found at PID: $PID"
    kill $PID
fi

 COUNT=0
 while [[ "$(ps aux | grep $BIN | grep -v grep | wc -l | tr -d '[:space:]')" -gt "1" ]]
 do
     echo "Waiting for mysqld pid to die..."
     sleep 1
     COUNT=$(expr $COUNT + 1)
     if [ "$COUNT" -eq 10 ]; then
         echo "ERROR: mysqld pid never died. Aborting."
         exit 12
     fi
 done

echo "Mysqld pid has successfully died."
