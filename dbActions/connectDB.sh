#!/bin/bash

# Path: dbActions/connectDB.sh

if [ ! -d "dbs" ] || [ -z "$(ls -F dbs | grep / | cut -d/ -f1)" ]
then
    echo "No Databases Found"
    exit
fi


echo "Databases List:"
ls -F dbs | grep / | cut -d/ -f1 2>/dev/null
read -p "Database name to connect: " dbName
source ./utils/validateDBName.sh $dbName


if [ ! -d "dbs/$dbName" ]
then
    echo "Database Not Found"
    exit
else
    cd dbs/$dbName
    echo "You are connected to $dbName database"
    source ../../tbActions/tbMenu.sh
fi


