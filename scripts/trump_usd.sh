#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helpers.sh"

api_status=$(curl -s https://api.kraken.com/0/public/SystemStatus | jq '.result.status' | sed 's/\"//g')

get_price() {
    # Attempt to fetch TRUMP/USD price (adjust pair if TRUMP isn’t correct)
    price=$(curl -s https://api.kraken.com/0/public/Ticker?pair=TRUMPUSD | jq '.result.TRUMPUSD.a[0]' | sed 's/\"//g')

    if [[ $api_status == 'online' ]]; then
        if [[ -n "$price" && "$price" != "null" ]]; then
            echo "$price" | bc -l | awk '{printf "TRUMP $%.2f", $1}'
        else
            echo "TRUMP/USD pair not found"
        fi
    elif [[ $api_status == 'offline' ]]; then
        echo "TRUMP -"
    else
        echo "TRUMP -"
    fi
}

get_price
