#!/bin/bash

# Проверка параметров запуска
checkArguments() {
    if [[ $1 =~ ^[1-3]+$ ]]; then
        clearMode=$1
    else
        echo "Ошибка: Введите только 1 аргумент для запуска! В диапазоне от 1 до 3."
        exit 1
    fi
}

# Проверка наличия файла с логами
checkLogFile() {
    if ! [[ -f $logfile ]]; then
        echo "Ошибка: Файл с логами не найден."
        exit 1
    fi
}

# Проверка корректности введенной даты
checkDateTime() {
    local datetime="$1"
    local pattern="^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}$"

    if ! [[ $datetime =~ $pattern ]]; then
        echo "Ошибка: Некорректный формат даты и времени. Используйте формат 'YYYY-MM-DD HH:MM'."
        exit 1
    fi
}

# Проверка корректности маски файла
checkMask() {
    if ! [[ "$mask" =~ ^[a-zA-Z_]+\_[0-9]{6}$ || "$mask" =~ ^[a-zA-Z_]+\.[a-zA-Z]+\_[0-9]{6}$ ]]; then
        echo "Ошибка: Некорректный формат маски."
        exit 1
    fi
}

# Проверка свободного места на жестком диске
checkFreeSpace() {
    echo "Свободное место на жестком диске: $(df -h / | awk 'NR==2 {print $4}')"
}
