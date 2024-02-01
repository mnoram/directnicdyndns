#!/usr/bin/env bash
## (c) 2024 th@bogus.net
## Dynamic DNS updater for DirectNIC, uses dyndns.org to obtain your public IP
##
RCFILE="$HOME/.ddrc" # this is where you put your secret (KEY=<hex_string>)
OS=$(uname)
if [ -e $RCFILE ];then
    if [ $OS == "OpenBSD" ];
    then
        filemode=$(stat -nr "$RCFILE" | cut -d " " -f3 | tail -c 4)
    else
        filemode=$(stat -c "%a" "$RCFILE")
    fi
    if [[ "$filemode" == "400" || "$filemode" == "600" ]] 
    then
        KEY=$(grep "^KEY=" "$RCFILE" | cut -d '=' -f2)
    else
        echo "Fatal: wrong permissions on $RCFILE ($filemode), change to 0400 or 0600"
        exit 1
    fi
else
    echo "Fatal: $RCFILE does not exist, exiting."
    exit 1
fi

if [ $OS == "OpenBSD" ]
then
    IP_ADDRESS=$(ftp -V -M -o - http://checkip.dyndns.org/ | perl -ne 'print $1 if /Current IP Address: (\d+\.\d+\.\d+\.\d+)/') 
else
    if [ ! $(which curl) == "" ]
    then
        IP_ADDRESS=$(curl -s -o - http://checkip.dyndns.org | grep -oP '(?<=Current IP Address: )\d+\.\d+\.\d+\.\d+')
    else
        echo "Fatal: No curl, exiting."
        exit 1
    fi
fi

URL="https://directnic.com/dns/gateway/$KEY/?data=$IP_ADDRESS"

if [ $OS == "OpenBSD" ]
then
    RESULT=$(ftp -V -o - $URL 2>&1 /dev/null)
else
    RESULT=$(curl -s -o - $URL 2>&1 /dev/null)
fi

if [[ $RESULT == *'"result":"success"'* ]]
then
    exit 0
else
    echo "Fatal: Could not update your DNS record: $RESULT"
    exit 1
fi
