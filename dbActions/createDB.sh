#!/bin/bash

# Path: dbActions/createDB.sh

# Check if dbs directory exists
if [ ! -d "dbs" ] 
then
    mkdir dbs
fi

read -p  "Enter Database Name: " dbName

if [ -z "$dbName" ]
then
    echo "Database Name Can't Be Empty"
    exit
elif [[ $dbName =~ ^[0-9] ]]
then
    echo "Database Name Can't Start With Number"
    exit
elif [[ $dbName =~ [^a-zA-Z0-9_] ]]
then
    echo "Database Name Can't Contain Special Characters Or Space"
    exit
fi

if [ -d "/dbs/$dbName" ]
then
    echo "Database With Same Name Already Exist"
else
    mkdir dbs/$dbName
    echo "Database Created Successfully"
fi


