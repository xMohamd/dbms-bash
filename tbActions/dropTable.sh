#!/bin/bash

# Path: tbActions/dropTable.sh

# Check if there are tables to drop
if [ ! "$(ls)" ] 
then
    echo "There are no tables to show."
    read -n 1 -s -r -p "Press any key to continue..."
    exit
fi

# List the available tables using listTables.sh
echo "Tables:"
source ../../tbActions/listTables.sh


# Ask the user to enter the table name then check if the table exists
while true
do
    read -p "Enter the name of the table to drop: " tbName
    if [ ! -f "$tbName" ] || [ ! -f "$tbName.metadata" ]
    then
        echo "Table Doesn't Exist"
        read -n 1 -s -r -p "Press any key to continue..."
        exit
    fi
    break
done

# Delete the table file and the metadata file
rm $tbName
rm $tbName.metadata
