#!/bin/bash

# Path: tbActions/tbMenu.sh

PS3="Select an option (1-9): "

options=(
    "Create Table"
    "List Tables"
    "Drop Table"
    "Insert into Table"
    "Select All From Table"
    "Select From Table"
    "Select Record From Table"
    "Delete From Table"
    "Update Table"
    "Back to Main Menu"
)

while true
do
    clear
    select choice in "${options[@]}"
    do
        case $choice in
            "Create Table")    ../../tbActions/createTable.sh;;
            "List Tables")    source ../../tbActions/listTables.sh ;;
            "Drop Table")     ../../tbActions/dropTable.sh ;;
            "Insert into Table")  ../../tbActions/insertIntoTable.sh ;;
            "Select All From Table")  ../../tbActions/selectAllFromTable.sh ;;
            "Select From Table")  ../../tbActions/selectFromTable.sh ;;
            "Select Record From Table")  ../../tbActions/selectRecordFromTable.sh ;;
            "Delete From Table")  ../../tbActions/deleteFromTable.sh ;;
            "Update Table")  ../../tbActions/updateTable.sh ;;
            "Back to Main Menu") 
                cd ../..
                exit
                ;;
            *)
                echo "Invalid Choice"
                ;;
        esac
        break
    done
    # break
done