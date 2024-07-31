#!/bin/bash

process_logs() {
    local method="$1"
    local log_file="$2"

    case "$method" in
        1)
            awk '{print $0}' "$log_file" | sort -k9,9 ;;
        2)
            awk '{print $1}' "$log_file" | sort -u ;;
        3)
            awk '$9 ~ /^4|5/ {print $0}' "$log_file" ;;
        4)
            awk '$9 ~ /^4|5/ {print $1}' "$log_file" | sort -u ;;
        *)
            echo "Ошибка: Неверный метод обработки логов." && exit 1 ;;
    esac
}
