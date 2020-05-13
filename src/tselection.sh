#!/bin/bash
# README:
# This will detect if `brg` selection was successful for each test.

make
total=0
passed=0

for f in $(find ../test/tests_p1/pass -name "*.min" | sort); do
    ((total++))    
    ./minor -trace < $f 2>&1 | grep "selection successful"
    if [ $? -ne 0 ]; then
        echo "> failed $f"
    else
        echo "passed $f"
        ((passed++))
    fi
done

echo $passed/$total
