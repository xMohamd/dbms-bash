#!/bin/bash

# Path: tbActions/selectFromTable.sh

# Check if there are tables to insert into
if [ ! "$(ls)" ] 
then
    echo "There are no tables to show."
    exit
fi

# List the available tables using listTables.sh
echo "Tables:"
source ../../tbActions/listTables.sh

# Ask the user to enter the table name then check if the table exists
while true
do
    read -p "Enter the name of the table to select from: " tbName
    if [ ! -f "$tbName" ] || [ ! -f "$tbName.metadata" ]
    then
        echo "Table Doesn't Exist"
        continue
    fi
    break
done

# Ask the user to enter the column name then check if the column exists
while true
do
    read -p "Enter the name of the column to select from: " colName
    if [ ! "$(cat $tbName.metadata | awk -F: '{print $1}' | head -n -1)" ]
    then
        echo "Column Doesn't Exist"
        continue
    fi
    break
done

# field number of the column that the user selected
colNum=$(cat $tbName.metadata | awk -F: '{print $1}' | head -n -1 | grep -n "$colName" | cut -d: -f1)

# Print the column that the user selected
echo "$colName"

# Print only column data that user selected skip 1st line (column names)
awk -F: -v colNum="$colNum" 'NR>1{print $colNum}' $tbName