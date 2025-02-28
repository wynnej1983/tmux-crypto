#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" && pwd  )"
source "$CURRENT_DIR/helpers.sh"

api_status=$(curl -s  https://api.kraken.com/0/public/SystemStatus | jq '.result.status'| sed 's/\"//g')

get_price()
{
    price=$(curl -s https://api.kraken.com/0/public/Ticker\?pair\=BTCUSD | jq '.result.XXBTZUSD.a[0]' | sed 's/\"//g')

    if [[ $api_status == 'online' ]]; then
        echo "$price" | bc -l | awk '{printf "BTC $%.0f", $1}'
    elif [[ $api_status == 'offline' ]]; then
        echo "BTC -"
    else
        echo "BTC -"
    fi
}

get_price

