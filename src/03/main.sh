#!/bin/bash

source check_input.sh
source clean.sh
logfile="./log.txt"

checkArguments "$@"

case $clearMode in
    1) logClean ;;
    2) timeDateClean ;;
    3) maskClean ;;
esac

checkFreeSpace
