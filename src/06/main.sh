#!/bin/bash

# Импорт необходимых скриптов
source check_log_file.sh
source find_log_file.sh
source process_logs_with_goaccess.sh

# Проверка количества аргументов командной строки
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

# Проверка правильности выбора сортировки
if ! [[ $sort_choice =~ ^[1-4]$ ]]; then
    echo "Ошибка: Неверный выбор. Выберите число от 1 до 4."
    exit 1
fi

echo "Выберите вариант указания файла лога:"
echo "1. Указать путь к файлу"
echo "2. Искать файл в соседних директориях"
read -p "Введите ваш выбор (1 или 2): " file_choice

# Обработка выбора способа указания файла лога
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

# Определение текущей директории
current_dir=$(pwd)

# Путь к HTML-отчету в текущей директории
html_report="$current_dir/report.html"

# Порт для публикации отчета
report_port=8080

# Проверяем, установлен ли GoAccess
if ! command -v goaccess &> /dev/null
then
    echo "GoAccess не установлен. Пожалуйста, установите GoAccess для продолжения."
    exit 1
fi

# Удаление существующего отчета, если он есть
if [ -f "$html_report" ]; then
    # Переименовываем файл отчета с помощью уникального префикса
    mv "$html_report" "${html_report}_$(date +%s)"
fi

# Генерация HTML-отчета с помощью GoAccess
if goaccess "$log_file_path" -o "$html_report" --log-format=COMBINED
then
    echo "Отчет GoAccess сгенерирован: $html_report"
else
    echo "Не удалось сгенерировать отчет GoAccess."
    exit 1
fi

# Публикация отчета
echo "Отчёт GoAccess доступен по адресу http://localhost:$report_port/"
python3 -m http.server "$report_port"