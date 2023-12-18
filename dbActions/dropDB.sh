#!/bin/bash

# Path: dbActions/dropDB.sh

# Check if dbs directory exists or if it's empty
if [ ! -d "dbs" ] || [ -z "$(ls -F dbs | grep / | cut -d/ -f1)" ]
then
    echo "No Databases Found"
    exit
fi

echo "Databases List:"
# ./dbActions/listDBs.sh
ls -F dbs | grep / | cut -d/ -f1
read -p "Database name to delete: " dbName
source ./utils/validateDBName.sh $dbName


# check if dbName is directory or not if it's directory then delete it
if [ -d "dbs/$dbName" ]
    then
        rm -rf dbs/$dbName 2>/dev/null
        echo "Database Deleted Successfully"
    else
        echo "Database Not Found"
fi


