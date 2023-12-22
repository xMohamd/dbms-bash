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
if [ "$(ls)" ] 
then
    # Print the tables files with their columns
    for table in $(ls *.* | cut -d. -f1)
    do
        echo -n "$table: "
        # Extract the columns from the metadata file
        # head -n -1: ignore the last line (the primary key)
        columns=$(cat $table.metadata | awk -F: '{print $1}' | head -n -1) 
        echo $columns | tr ' ' ','
    done
else
    echo "There are no tables to show."
        read -n 1 -s -r -p "Press any key to continue..."
fi
# source ../../tbActions/listTables.sh


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
