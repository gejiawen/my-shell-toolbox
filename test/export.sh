#!/usr/bin/env bash

if [[ -z $TEST_ENV ]]; then
    export TEST_ENV=1
    echo $TEST_ENV
else
    # export TEST_ENV=ook
    echo 2
fi

