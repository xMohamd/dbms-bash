#!/bin/bash

# Path: dbActions/listDBs.sh

if [ ! -d "dbs" ]
then
    echo "No Databases Found"
else
   ls -F dbs | grep / | cut -d/ -f1 2>/dev/null
fi