#!/bin/bash

while true
do
    if [ -z "$DROP_DIR" ]
    then
        DROP_DIR="/input-dir"
    fi

    if [ -z "$FILE_MOD_CMIN" ]
    then
        FILE_MOD_CMIN="+0.5"
    fi

    NEW_FILES=$(find $DROP_DIR -type f -name *.zip -cmin $FILE_MOD_CMIN)
    PORT=3333

    for NEW_FILE in $NEW_FILES
    do
        echo "Processing file $NEW_FILE"
        IP_DIR=$(dirname $NEW_FILE)
        IP=$(basename $IP_DIR)
        TYPE_DIR=$(dirname $IP_DIR)
        TYPE=$(basename $TYPE_DIR)
        ENV_DIR=$(dirname $TYPE_DIR)
        ENV=$(basename $ENV_DIR)
        FILENAME=$(basename $NEW_FILE)
        unzip -c $NEW_FILE | cat -n | sed "s/^[[:space:]]*\([0-9]\{1,\}\)[[:space:]]*\([0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]\)[[:space:]]*\([0-9][0-9]:[0-9][0-9]:[0-9][0-9]\) \(.*\)/\2 \3 [host=$IP, type=$TYPE, environment=$ENV, file=$IP\/$FILENAME, lineNumber=\1] \4/g" | sed "s/^[[:space:]]*[0-9]\{1,\}[[:space:]]\(.*\)/\1/g" | nc logstash $PORT
        rm -f $NEW_FILE
    done
    echo "Indexing of batch has been finished."
    sleep 10
done

