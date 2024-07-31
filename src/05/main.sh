#!/bin/bash

source check_log_file.sh
source find_log_file.sh
source process_logs.sh

# Проверка, передан ли параметр при запуске
if [ "$#" -ne 1 ]; then
    echo "Выберите вариант сортировки логов:"
    echo "1. Все записи, отсортированные по коду ответа"
    echo "2. Все уникальные IP, встречающиеся в записях"
    echo "3. Все запросы с ошибками (код ответа - 4хх или 5хх)"
    echo "4. Все уникальные IP, которые встречаются среди ошибочных запросов"
    read -p "Введите ваш выбор (1-4): " sort_choice
else
    sort_choice="$1"
fi

# Проверка ввода пользователя
if ! [[ $sort_choice =~ ^[1-4]$ ]]; then
    echo "Ошибка: Неверный выбор. Выберите число от 1 до 4."
    exit 1
fi

echo "Выберите вариант указания файла лога:"
echo "1. Указать путь к файлу"
echo "2. Искать файл в соседних директориях"
read -p "Введите ваш выбор (1 или 2): " file_choice

if [ "$file_choice" -eq 1 ]; then
    read -p "Введите путь к файлу лога: " log_file_path
    if ! check_log_file "$log_file_path"; then
        echo "Ошибка: Файл лога не найден."
        exit 1
    fi
elif [ "$file_choice" -eq 2 ]; then
    log_file_path=$(find_log_file)
    if [ -z "$log_file_path" ]; then
        echo "Ошибка: Файл лога не найден."
        exit 1
    fi
else
    echo "Ошибка: Неверный выбор."
    exit 1
fi

process_logs "$sort_choice" "$log_file_path"
