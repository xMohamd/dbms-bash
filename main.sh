#!/bin/bash 

PS3="Select option (1-5): "

options=(
 "Create Database"
 "List Databases"
 "Connect To Specific Database"
 "Drop Database"
 "Exit"
)
select choice in "${options[@]}"
do 
    case $choice in 
        "Create Database")  
        dbActions/createDB.sh
            ;;
        "List Databases")
        dbActions/listDBs.sh
            ;;
        "Connect To Specific Database")
        source dbActions/connectDB.sh
            ;;
        "Drop Database")
        dbActions/dropDB.sh
            ;;
        "Exit") 
            exit
            ;;
        *)
            echo "Invalid Choice"
            ;;
    esac
done