#!/bin/bash

# Импорт других скриптов
source validate_input.sh
source generate_name.sh

# Основная логика
validateInput "$@"
startGeneration
