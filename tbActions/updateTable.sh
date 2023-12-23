#!/bin/bash

# Path: tbActions/updateTable.sh

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
    read -p "Enter the name of the table to update: " tbName
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

# determine the number of separator in the table based on the number of columns
sepNum=$(($(cat $tbName.metadata | wc -l) - 2))

# ask the about the primary key value of the record that the user want to update
while true
do
    read -p "Enter the value of the primary key ($pk) to update: " pkValue
    # search for the primary key value in the table if it's exist or not
    if [ ! "$(awk -F: -v pkNum="$pkNum" -v pkValue="$pkValue" '$pkNum==pkValue' $tbName)" ] || [[ "$pkValue" = "" ]]
    then
        echo "Value Doesn't Exist"
        read -n 1 -s -r -p "Press any key to continue..."
        exit
    fi
    break
done

# ask the user about the column name that he want to update
while true
do
    read -p "Enter the name of the column to update: " colName
    # check if the column name is the primary key
    if [ "$colName" = "$pk" ]
    then
        echo "You can't update the primary key"
        read -n 1 -s -r -p "Press any key to continue..."
        exit
    fi

    # search for the column name in the table if it's exist or not
    if [ ! "$(cat $tbName.metadata | awk -F: '{print $1}' | head -n -1 | grep "$colName")" ] || [[ "$colName" = "" ]]
    then
        echo "Column Doesn't Exist"
        read -n 1 -s -r -p "Press any key to continue..."
        exit
    fi
    break
done

# ask the user about the new value of the column
while true
do
    read -p "Enter the new value of $colName: " newValue
    # validate the new value of the column
    source ../../utils/validateValue.sh "$newValue" "$colName" "$tbName"
    if [ $? -ne 0 ] 
    then
        continue
    fi
    break
done


# Extract the column number of the column that the user want to update  
colNum=$(cat $tbName.metadata | awk -F: '{print $1}' | head -n -1 | grep -n "$colName" | cut -d: -f1)

# Extract the old value of the column that the user want to update
oldValue=$(awk -F: -v pkNum="$pkNum" -v pkValue="$pkValue" '$pkNum==pkValue' $tbName | cut -d: -f"$colNum")

# determine the primary key column name
pkName=$(awk -F: '{if ($2 == "'$pkValue'") print $1}' $tbName)

# replace the old value with the new value and update the line that contains the primary key value
sed -i "/$pkValue/s/$oldValue/$newValue/" $tbName
echo "Record Updated Successfully"
read -n 1 -s -r -p "Press any key to continue..."