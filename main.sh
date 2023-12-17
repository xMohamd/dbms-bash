#!/bin/bash 

PS3="Select option (1-5): "

select choice in "Create Database" "List Databases" "Connect To Specific Database" "Drop Database" "Exit"
do 
    case $choice in 
        "Create Database")  
        dbActions/createDB.sh
            ;;
        "List Databases")
        dbActions/listDBs.sh
            ;;
        "Connect To Specific Database")
            read -p "Enter Database Name: " dbName
            cd $dbName
            PS3="Select Table: "
            select table in $(ls)
            do 
                if [[ -f $table ]]
                then 
                    echo "Table Selected Successfully"
                    break
                else 
                    echo "Invalid Choice"
                fi
            done
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