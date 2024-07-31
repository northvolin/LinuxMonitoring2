#!/bin/bash

# Очистка по лог-файлу
logClean() {
    checkLogFile
    checkFreeSpace

    echo "Очистка по лог-файлу..."
    while read -r line; do
        path=$(echo "$line" | awk '{print $1}')
        sudo rm -rf "$path" 2>/dev/null
    done < log.txt
}

# Очистка по временным меткам
timeDateClean() {
    checkFreeSpace
    logFile="logrm.txt"

    echo "Введите дату и время создания файлов в формате: $(date '+%Y-%m-%d %H:%M')"

    read -p "Введите время начала создания файлов: " startTime
    checkDateTime "$startTime"
    read -p "Введите время конца создания файлов: " endTime
    checkDateTime "$endTime"

    sudo find / -newermt "$startTime" -not -newermt "$endTime" 2>/dev/null | while read -r file; do
        if [[ $file =~ _[0-9]{6}$ ]]; then
            echo "Удален: $file" >> "$logFile"
            sudo rm -r "$file" 2>/dev/null
        fi
    done

    echo "Удаление завершено." >> "$logFile"
}

# Очистка по маске
maskClean() {
    read -p "Введите маску в формате foldername_$(date '+%d%m%y') или filename.txt_$(date '+%d%m%y'): " mask
    checkMask

    checkFreeSpace
    echo "Ищем и удаляем файлы по маске $mask..."

    find / -type f -name "*$mask*" 2>/dev/null | xargs sudo rm -f
    find / -type d -name "*$mask*" 2>/dev/null | xargs sudo rm -rf

    echo "Удаление завершено."
}
