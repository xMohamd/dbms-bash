#!/bin/bash

# Path: dbActions/createDB.sh

# Check if dbs directory exists
if [ ! -d "dbs" ] 
then
    mkdir dbs
fi

while true
do
    read -p "Enter the name of the database: " dbName
    source ./utils/validateName.sh $dbName
    if [ $? -ne 0 ]; then
        read -n 1 -s -r -p "Press any key to continue..."
        exit
    fi
        break
done


if [ -d "/dbs/$dbName" ]
then
    echo "Database With Same Name Already Exist"
else
    mkdir dbs/$dbName
    echo "Database Created Successfully"
fi
read -n 1 -s -r -p "Press any key to continue..."

