#!/bin/bash

# Path: dbActions/connectDB.sh

if [ ! -d "dbs" ] || [ -z "$(ls -F dbs | grep / | cut -d/ -f1)" ]
then
    echo "No Databases Found"
    read -n 1 -s -r -p "Press any key to continue..."
    exit
fi


echo "Databases List:"
ls -F dbs | grep / | cut -d/ -f1 2>/dev/null
read -p "Database name to connect: " dbName

while true
do
    source ./utils/validateName.sh $dbName
    if [ $? -ne 0 ]; then
        read -n 1 -s -r -p "Press any key to continue..."
        exit
    fi
    break
done


if [ ! -d "dbs/$dbName" ]
then
    echo "Database Not Found"
else
    cd dbs/$dbName
    echo "You are connected to $dbName database"
    ../../tbActions/tbMenu.sh
    exit
fi
read -n 1 -s -r -p "Press any key to continue..."

