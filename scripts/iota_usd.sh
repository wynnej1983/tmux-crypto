#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" && pwd  )"
source "$CURRENT_DIR/helpers.sh"

api_status=$(curl -s  https://api-pub.bitfinex.com/v2/platform/status | jq '.[0]')

get_price()
{
    price=$(curl -s https://api-pub.bitfinex.com/v2/ticker/tIOTUSD | jq '.[6]')

    if [[ $api_status == 1 ]]; then
        echo "$price" | bc -l | awk '{printf "IOTA $%.2f", $1}'
    elif [[ $api_status == 0 ]]; then
        echo "IOTA -"
    else
        echo "IOTA -"
    fi
}

get_price

