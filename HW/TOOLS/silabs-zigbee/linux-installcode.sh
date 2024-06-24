#!/bin/bash

## THIS FILE IS USED FOR PROGRAMMING INSTALLATION CODE AUTOMATICALLY.

## Functions
end () {
    rm $TEMPFILE
    #echo "Cleaned up $TEMPFILE..."
    exit $1
}

## Variables
TEMPFILE=$(mktemp)
DEFAULT_INSTALL_CODE="83FED3407A939723A5C639B26916D505"
ADAPTER=$1 # Take First Parameter adapter serial number
## Starting Message
#echo "Created file $TEMPFILE..."

## Use of PATH_SCMD env variable to Override default path
if [ -z "$PATH_SCMD" ]; then
    echo "Error Commander Path variable 'PATH_SCMD' not set"
    end 1
fi
# Set the Commander Path
COMMANDER="$PATH_SCMD/commander"

## Probe For use of Particular Adapter
$COMMANDER adapter probe > $TEMPFILE
echo "Found Adapters connected:"
sed -n -e '/Available USB serial numbers/,$p' $TEMPFILE |\
 tail -n +2 | head -n -1
echo

## Check if we have the Adapter
if [ -z "$ADAPTER" ]; then
    echo "Error Adapter serial number not found !"
    echo "  Please add the first parameter as the <adapter serial> shown"
    echo
    end 2
fi
echo "Connecting using Adapter $ADAPTER..."
if [ -z "$2" ]; then
    echo "Using default install code: $DEFAULT_INSTALL_CODE"
else
    DEFAULT_INSTALL_CODE=$2
    echo "Using Supplied install code: $DEFAULT_INSTALL_CODE"
fi
echo
$COMMANDER flash -s $ADAPTER --tokengroup znet \
    --token "Install Code: !ERASE!"
echo
$COMMANDER flash -s $ADAPTER --tokengroup znet \
    --token "Install Code:$DEFAULT_INSTALL_CODE"
echo
$COMMANDER tokendump -s $ADAPTER --tokengroup znet \
    --token TOKEN_MFG_INSTALLATION_CODE
echo

# Normal End
end 0
