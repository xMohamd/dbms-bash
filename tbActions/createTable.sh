#!/bin/bash

# Path: tbActions/createTable.sh

# Ask the user to enter the table name using loop until the name is valid
while true
do
    read -p "Enter the name of the table: " tbName
    echo $tbName
    source ../../utils/validateName.sh "$tbName"
    if [ $? -ne 0 ]; then
    continue
    fi
    break
done

if [ -f "$tbName" ] || [ -f "$tbName.metadata" ]
then
    echo "Table Already Exists"
    exit
fi

# Ask the user to enter the number of columns using loop until the number is valid
while true
do
    read -p "Enter the number of columns: " colsNum
    # Validate Number of Columns
    # Cheack if the colsNum isn't a number
    # ^[0-9]+$ means (^) start with any number (0-9), ($) end with any number (0-9) and (+) one or more
    if [[ ! $colsNum =~ ^[0-9]+$ ]]
    then
        echo "Number of Columns Must Be a Number"
        exit
    # Check if the colsNum equal 0
    elif [ $colsNum -eq 0 ]
    then
        echo "Number of Columns Must Be Greater Than 0"
        exit  
    fi
    break
done


# Create a metadata file and file for the table
touch "$tbName.metadata"
touch "$tbName"


# Loop on the number of columns
counter=1
while [ $counter -le $colsNum ]
do
    # Ask the user to enter the column name using loop until the name is valid
    while true
    do
        read -p "Enter the name of column #$counter: " colName
        source ../../utils/validateName.sh "$colName"
        if [ $? -ne 0 ]; then
            continue
        fi
        break
    done

    # Ask the user to choose the column type using loop until the type is valid
    while true
    do
        echo "Choose the type of column #$counter:"
        PS3="Select an option (1-2): "
        select colType in "integer" "string" 
        do 
            case $colType in
                "integer" | "string" ) break ;;
                *) echo "Invalid Choice" ;;
            esac
        done
        break
    done

    # Append the column name and type to the metadata file
    echo "$colName:$colType" >> $tbName.metadata

    # Append the column name to the table file
    echo -n "$colName " >> $tbName

    ((counter++))
done

# Ask the user to choose the primary key using select and case
pk_check=false
while [ "$pk_check" = false ]
do 
    echo "Choose the primary key:"
    PS3="Select an option (1-$colsNum): "
    select primaryKeyCol in $(cut -d: -f1 "$tbName.metadata") 
    do 
        if [ -n "$primaryKeyCol" ]; then
            echo "$primaryKeyCol:primarykey" >> "$tbName.metadata"
            pk_check=true
            break
        else
            echo "Invalid Choice"
        fi
    done
done

source ../../tbActions/tbMenu.sh