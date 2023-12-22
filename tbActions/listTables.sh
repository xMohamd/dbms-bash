#!/bin/bash

# Path: tbActions/listTables.sh
if [ "$(ls)" ] 
then
    # Print the tables files with their columns
    for table in $(ls *.* | cut -d. -f1)
    do
        echo -n "$table: "
        # Extract the columns from the metadata file
        # head -n -1: ignore the last line (the primary key)
        columns=$(cat $table.metadata | awk -F: '{print $1}' | head -n -1) 
        echo $columns | tr ' ' ','
    done
    # Check if the script is called from tbMenu.sh if not return to the call script
    if [[ "$0" != "../../tbActions/tbMenu.sh" ]]
    then
        # return to call script
        return
    fi
else
    echo "There are no tables to show."
fi
read -n 1 -s -r -p "Press any key to continue..."
