#!/bin/bash

# Импорт других скриптов
source validate_input.sh
source generate_name.sh


# Основная логика
startTime=$(date +%s)
timeRunIn=$(date +%H:%M:%S)

validateInput "$@"
startGeneration
finalLog

cp ./logfile.txt ../03/