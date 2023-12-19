#!/bin/bash

# Path: tbActions/tbMenu.sh

PS3="Select an option (1-8): "

options=(
    "Create Table"
    "List Tables"
    "Drop Table"
    "Insert into Table"
    "Select From Table"
    "Delete From Table"
    "Update Table"
    "Back to Main Menu"
)

select choice in "${options[@]}"
do
    case $choice in
        "Create Table")   source ../../tbActions/createTable.sh;;
        "List Tables")    source ../../tbActions/listTables.sh ;;
        "Drop Table")     source ../../tbActions/dropTable.sh ;;
        "Insert into Table") source ../../tbActions/insertIntoTable.sh ;;
        "Select From Table") source ../../tbActions/selectFromTable.sh ;;
        "Delete From Table") source ../../tbActions/deleteFromTable.sh ;;
        "Update Table") source ../../tbActions/updateTable.sh ;;
        "Back to Main Menu") 
            cd ../..
            source ./main.sh
            ;;

        *)
            echo "Invalid Choice"
            ;;
    esac
done
