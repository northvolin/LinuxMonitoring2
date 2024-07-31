#!/bin/bash

find_log_file() {
    # Поиск файлов лога в соседних директориях и возвращение первого найденного
    local log_files=$(find .. -name "nginx_log*.log" -print -quit)

    if [ ! -z "$log_files" ]; then
        echo "$log_files"
    else
        echo ""
    fi
}
