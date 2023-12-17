#!/bin/bash

# Path: dbActions/dropDB.sh

if [ ! -d "dbs" ] || [ -z "$(ls -F dbs | grep / | cut -d/ -f1)" ]
then
    echo "No Databases Found"
    exit
fi

echo "Databases List:"
# ./dbActions/listDBs.sh
ls -F dbs | grep / | cut -d/ -f1
read -p "Database name to delete: " dbName



if [ -d "dbs/$dbName" ]
    then
        rm -rf dbs/$dbName 2>/dev/null
        echo "Database Deleted Successfully"
    else
        echo "Database Not Found"
fi


