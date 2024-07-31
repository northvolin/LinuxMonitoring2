#!/bin/bash

find_log_file() {
    local log_files=$(find .. -name "nginx_log*.log" -print -quit)

    if [ ! -z "$log_files" ]; then
        echo "$log_files" # Возвращает путь к найденному файлу
    else
        echo "Файл не найден" # Возвращает строку, если файл не найден
    fi
}
