#!/bin/bash

# Path: utils/checkName.sh

function validateDBName {
    local dbName=$1

    if [ -z "$dbName" ]; then
        echo "Database Name Can't Be Empty"
        exit 1
    elif [[ $dbName =~ ^[0-9] ]]; then
        echo "Database Name Can't Start With a Number"
        exit 1
    elif [[ $dbName =~ [^a-zA-Z0-9_] ]]; then
        echo "Database Name Can't Contain Special Characters Or Space"
        exit 1
    fi
}

validateDBName $1