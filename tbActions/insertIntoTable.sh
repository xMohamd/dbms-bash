#!/bin/bash

# Path: tbActions/insertIntoTable.sh

# Check if there are tables to insert into
if [ ! "$(ls)" ] 
then
    echo "There are no tables to show."
    read -n 1 -s -r -p "Press any key to continue..."
    exit
fi

# List the available tables using listTables.sh
source ../../tbActions/listTables.sh

# Ask the user to enter the table name then check if the table exists
while true
do
    read -p "Enter the name of the table: " tbName
    if [ ! -f "$tbName" ] || [ ! -f "$tbName.metadata" ]
    then
        echo "Table Doesn't Exist"
        read -n 1 -s -r -p "Press any key to continue..."
        exit
    fi
    break
done

# Initialize an array with the columns names
columns_names=($(cat $tbName.metadata | awk -F: '{print $1}' | head -n -1))

# Loop on the columns names
for col in ${columns_names[@]}
do
    # Ask the user to enter the value of the column as the data type of the column
    while true
    do
        read -p "Enter the value of $col: " value
        # Validate the value of the column
        source ../../utils/validateValue.sh "$value" "$col" "$tbName"
        if [ $? -ne 0 ] 
        then
            continue
        fi
        break
    done
    # Append the value to the table file
    echo -n "$value" >> $tbName
    # Append a colon to the table file if the column isn't the last column [-1] (ignore the primary key)
    if [ "$col" != "${columns_names[-1]}" ]
    then
        echo -n ":" >> "$tbName"
    fi
done

# Append a new line to the table file
echo >> $tbName