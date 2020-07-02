#!/usr/bin/env bash

set -euo pipefail

while read line; do
    if [[ $line =~ ^#[[:space:]]com.matlowery.hs.end ]]; then
        echo
        exit 0
    fi
    echo "$line" >> ~/.hs_history
done
