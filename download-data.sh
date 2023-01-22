#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
    echo 'Usage: ./script.sh arg-one arg-two

This is an awesome bash script to make your life better.

'
    exit
fi

cd "$(dirname "$0")"

main() {
    cd data
    months='01 02 03 04 05 06 07 08 09 10 11 12'
    for mo in $months; do
        df="2022{$mo}-divvy-tripdata.zip"
        curl "https://divvy-tripdata.s3.amazonaws.com/$df" --output "$df"
        unzip "$df" -x __MACOSX/*.csv
        rm "$df"
    done
}

main "$@"