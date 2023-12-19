#!/bin/bash

# Path: utils/validateName.sh
# echo "inside validateName.sh " "$1"
function validateName {
    
    if [ -z "$1" ]
    then
        echo "Name Can't Be Empty"
        return 1
    elif [[ "$1" =~ ^[0-9] ]] 
    then
        echo "Name Can't Start With a Number"
        return 1
    elif [[ "$1" = *" "* ]]
    then
        echo "Name Can't Contain Spaces"
        return 1
    elif [[ "$1" =~ [^a-zA-Z0-9_] ]]
    then
        echo "Name Can't Contain Special Characters"
        return 1
    fi
}

validateName "$1"
