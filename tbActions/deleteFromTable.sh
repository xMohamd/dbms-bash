#!/bin/bash

# Path: tbActions/deleteFromTable.sh

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
    read -p "Enter the name of the table to delete from: " tbName
    if [ ! -f "$tbName" ] || [ ! -f "$tbName.metadata" ]
    then
        echo "Table Doesn't Exist"
        read -n 1 -s -r -p "Press any key to continue..."
        exit
    fi
    break
done

# check if the table is empty cosidering ignoring the first line (column names)
if [ ! "$(awk 'NR>1' $tbName)" ]
then
    echo "Table is Empty"
    read -n 1 -s -r -p "Press any key to continue..."
    exit
fi

# determine the primary key
pk=$(cat $tbName.metadata | awk -F: '{print $1}' | tail -1)

# detetmine the column number of the primary key
pkNum=$(cat $tbName.metadata | awk -F: '{print $1}' | head -n -1 | grep -n "$pk" | cut -d: -f1)

# Ask the user to enter the primary key value then check if the value exists
while true
do
    read -p "Enter the value of the primary key ($pk) to delete: " pkValue
    # search for the primary key value in the table if it's exist or not
    if [ ! "$(awk -F: -v pkNum="$pkNum" -v pkValue="$pkValue" '$pkNum==pkValue' $tbName)" ]
    then
        echo "Value Doesn't Exist"
        continue
    fi


    break
done

# delete the record with the primary key value that the user entered using sed
sed -i "/^$pkValue/d" $tbName
