#!/bin/bash

# Path: tbActions/selectAllFromTable.sh

# Check if there are tables to insert into
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
    read -p "Enter the name of the table to select from: " tbName
    if [ ! -f "$tbName" ] || [ ! -f "$tbName.metadata" ]
    then
        echo "Table Doesn't Exist"
        read -n 1 -s -r -p "Press any key to continue..."
        exit
    fi
    break
done

# Print the column names with a tab between each two columns
awk -F: '{print $1}' $tbName.metadata | head -n -1 | tr '\n' '\t'

echo ""

# Print the table data skip 1st line (column names)
awk -F: 'NR>1{for(i=1;i<=NF;i++) printf "%s\t", $i; print ""}' $tbName
read -n 1 -s -r -p "Press any key to continue..."