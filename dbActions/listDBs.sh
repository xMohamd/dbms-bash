#!/bin/bash

# Path: dbActions/listDBs.sh

# Press any key to continue

if [ ! -d "dbs" ]
then
    echo "No Databases Found"
else
   ls -F dbs | grep / | cut -d/ -f1 2>/dev/null
fi
read -n 1 -s -r -p "Press any key to continue..."