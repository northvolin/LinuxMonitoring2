#!/bin/bash

# Функция для генерации случайной даты в рамках заданного дня
generate_date() {
    local date="$1"
    echo "[$(date -d "$date" +'%d/%b/%Y:%H:%M:%S %z')]"
}
