#!/usr/bin/env sh

# #!/bin/bash

# @author      : Luis Miguel Baez <es.luismiguelbaez@gmail.com>

# Shell Colors

reset="\033[0m";
red_fill="\033[7;107;91m";
red_bold="\033[1;31m";
blue_fill="\033[7;49;34m";
blue_bold="\033[49;34m";
green_fill="\033[7;49;32m";
green_bold="\033[49;32m";
yellow_fill="\033[7;49;33m";
yellow_bold="\033[49;33m";
white_fill="\033[7;49;20m";
white_bold="\033[49;20m";

# Check Arguments
if [ "$1" = "" ]; then
    echo "usage: ./testing_tle.sh [filename fast] [filename slow] [generator filename]"
    exit 0
fi

if [ "$2" = "" ]; then
    echo "usage: ./testing_tle.sh [filename fast] [filename slow] [generator filename]"
    exit 0
fi

if [ "$3" = "" ]; then
    echo "usage: ./testing_tle.sh [filename fast] [filename slow] [generator filename]"
    exit 0
fi

# Delete binaries
rm -f ".o"
rm -f "*.in"
rm -f "*.out"

# Username
echo "\n📌 ${red_bold}@SorKierkegaard${reset}\n"

# C++ Compiler

# Filename fast
g++ -std=c++17 -Wextra -O2 -DLOCAL=1 -o "$1.o" "$1.cpp"
# g++ -std=c++17 -DONLINE_JUDGE=1 -o "$1.o" "$1.cpp"

# Filename slow
g++ -std=c++17 -Wextra -O2 -DLOCAL=1 -o "$2.o" "$2.cpp"
# g++ -std=c++17 -DONLINE_JUDGE=1 -o "$2.o" "$2.cpp"

# Generator filename
g++ -std=c++17 -Wextra -O2 -DLOCAL=1 -o "$3.o" "$3.cpp"
# g++ -std=c++17 -DONLINE_JUDGE=1 -o "$3.o" "$3.cpp"

# Execute all testcases

touch testcase.in
touch testcase.out
touch expected_testcase.out

for i in $(seq 1 100000);
do
    # Show testcase filename
    echo "🔴 ${yellow_fill}File '$i'${reset}"
    
    # Generate testcase
    timeout 2s ./$3.o > testcase.in

    # Execute expected test case
    timeout 2s ./$2.o > expected_testcase.out < testcase.in

    # Time Elapsed
    START_TIME=$(date +%s%N);
    echo "-$white_fill"

    # Execute Testcase
    timeout 2s ./$1.o > testcase.out < testcase.in

    END_TIME=$((($(date +%s%N) - $START_TIME)/1000000));
    
    # Show testcase output
    diff -w testcase.out expected_testcase.out || break

    echo "$reset-"
    
    # Check TLE and Show execution time
    if [ "$END_TIME" -lt 2000 ]; then
        echo "🌀 ${green_fill}Finished in : ${reset}${yellow_fill}$END_TIME${reset}${green_fill} ms$reset"
    else
        echo "⛔ ${red_fill}Time Limit Exceeded : ${reset}${yellow_fill}$END_TIME${reset}${red_fill} ms$reset"
    fi
    echo ""
    echo "${green_bold}≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡${reset}"
    echo ""
done

rm -f "$2.o"
