#!/usr/bin/env sh

# @author  : Luis Miguel Baez <es.luismiguelbaez@gmail.com>

# Flags

./run_tests.sh "$1" "$2" "$3"

./diff.sh "$1"
