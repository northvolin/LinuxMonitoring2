#!/bin/bash

check_log_file() {
    local log_file="$1"

    if [ -f "$log_file" ]; then
        return 0 # Файл существует
    else
        return 1 # Файл не найден
    fi
}
