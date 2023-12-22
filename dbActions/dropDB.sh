#!/bin/bash

# Path: dbActions/dropDB.sh

# Check if dbs directory exists or if it's empty
if [ ! -d "dbs" ] || [ -z "$(ls -F dbs | grep / | cut -d/ -f1)" ]
then
    echo "No Databases Found"
    read -n 1 -s -r -p "Press any key to continue..."
    exit
fi

echo "Databases List:"
# ./dbActions/listDBs.sh
ls -F dbs | grep / | cut -d/ -f1
read -p "Database name to delete: " dbName



while true
do
    source ./utils/validateName.sh $dbName
    if [ $? -ne 0 ]; then
        read -n 1 -s -r -p "Press any key to continue..."
        exit
    fi
    break
done



# check if dbName is directory or not if it's directory then delete it
if [ -d "dbs/$dbName" ]
    then
        rm -rf dbs/$dbName 2>/dev/null
        echo "Database Deleted Successfully"
    else
        echo "Database Not Found"
fi
read -n 1 -s -r -p "Press any key to continue..."

