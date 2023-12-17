#!/bin/bash

# Path: dbActions/createDB.sh

# Check if dbs directory exists
if [ ! -d "dbs" ] 
then
    mkdir dbs
fi

read -p  "Enter Database Name: " dbName
source ./utils/validateDBName.sh $dbName


if [ -d "/dbs/$dbName" ]
then
    echo "Database With Same Name Already Exist"
else
    mkdir dbs/$dbName
    echo "Database Created Successfully"
fi


