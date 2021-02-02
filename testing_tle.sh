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
    echo "usage: ./testing_tle.sh [filename to test] [generator filename]"
    exit 0
fi

if [ "$2" = "" ]; then
    echo "usage: ./testing_tle.sh [filename to test] [generator filename]"
    exit 0
fi

# Delete binaries
rm -f ".o"
rm -f "*.in"
rm -f "*.out"

# Username
echo "\n📌 ${red_bold}@SorKierkegaard${reset}\n"

# C++ Compiler

# Filename
g++ -std=c++17 -Wextra -O2 -DLOCAL=1 -o "$1.o" "$1.cpp"
# g++ -std=c++17 -DONLINE_JUDGE=1 -o "$1.o" "$1.cpp"

# Generator filename
g++ -std=c++17 -Wextra -O2 -DLOCAL=1 -o "$2.o" "$2.cpp"
# g++ -std=c++17 -DONLINE_JUDGE=1 -o "$2.o" "$2.cpp"

# Execute all testcases

touch testcase.in
touch testcase.out

for i in $(seq 1 100000);
do
    # Show testcase filename
    # echo "$i\n";
    echo "🔴 ${yellow_fill}File '$i'${reset}"
    
    # Generate testcase
    timeout 2s ./$2.o > testcase.in

    # Time Elapsed
    START_TIME=$(date +%s%N);

    # Execute Testcase
    timeout 2s ./$1.o > testcase.out < testcase.in

    END_TIME=$((($(date +%s%N) - $START_TIME)/1000000));
    
    # Check TLE and Show execution time
    if [ "$END_TIME" -lt 2000 ]; then
        echo "🌀 ${green_fill}Finished in : ${reset}${yellow_fill}$END_TIME${reset}${green_fill} ms$reset"
    else
        echo "-$white_fill"
        cat testcase.in
        echo "$reset-"

        echo "⛔ ${red_fill}Time Limit Exceeded : ${reset}${yellow_fill}$END_TIME${reset}${red_fill} ms$reset"
    fi
    echo ""
    echo "${green_bold}≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡${reset}"
    echo ""
done
