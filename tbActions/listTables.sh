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
else
    echo "There are no tables to show."
fi