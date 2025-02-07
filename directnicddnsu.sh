#!/usr/bin/env bash
## (c) 2024 th@bogus.net
## Dynamic DNS updater for DirectNIC, uses dyndns.org to obtain your public IP
## 2025 update by mnoram for personal use only

RCFILE="$HOME/.ddrc" # this is where you put your secret (KEY=<hex_string>)

KEY=$(grep "^KEY=" "$RCFILE" | cut -d '=' -f2)

IP_ADDRESS=$(curl -s -o - http://checkip.dyndns.org | grep -oP '(?<=Current IP Address: )\d+\.\d+\.\d+\.\d+')

URL="https://directnic.com/dns/gateway/$KEY/?data=$IP_ADDRESS"

RESULT=$(curl -s -o - $URL 2>&1 /dev/null)

if [[ $RESULT == *'"result":"success"'* ]]
then
    exit 0
else
    echo "Fatal: Could not update your DNS record: $RESULT"
    exit 1
fi
