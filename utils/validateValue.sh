#!/bin/bash

# Path: utils/validateValue.sh

# Function to validate the value of the column based on the data type of the column in the metadata file
# $1: value
# $2: column name
# $3: table name
function validateValue() {
    # Check if the value is null
    if [ -z "$1" ]; then
        echo "The value of $2 can't be null."
        return 1
    fi

    # Check if the value is a number
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        # Check if the data type of the column contains "integer"
        dataType=$(awk -F: -v col="$2" '$1 == col {print $2}' "$3.metadata" | grep -o 'integer')
        if [ "$dataType" == "integer" ]; then
            return 0
        else
            echo "The value of $2 must be a string."
            return 1
        fi
    fi

    # Check if the value is a string
    if [[ "$1" =~ ^[a-zA-Z0-9_]+$ ]]; then
        # Check if the data type of the column contains "string"
        dataType=$(awk -F: -v col="$2" '$1 == col {print $2}' "$3.metadata" | grep -o 'string')
        if [ "$dataType" == "string" ]; then
            return 0
        else
            echo "The value of $2 must be a number."
            return 1
        fi
    fi

    # If the value is not a number or a string, it's invalid
    echo "The value of $2 must be a number or a string."
    return 1
}

validateValue "$1" "$2" "$3"
