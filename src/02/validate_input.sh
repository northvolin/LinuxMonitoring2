#!/bin/bash

# Основная функция проверки входных параметров
validateInput() {
    checkArguments "$@"
    checkFolderName "$1"
    checkFileName "$2"
    checkFileSize "$3"
}

# Проверяем количество параметров
checkArguments() {
    if [ $# -ne 3 ]; then
        echo "Ошибка: Введите 3 аргумента для запуска!"
        exit 1
    fi
}

# Проверяем название папок
checkFolderName() {
    if [[ ${#1} -le 7 && "$1" =~ ^[a-zA-Z_]+$ ]]; then
        foldersName="$1"
    else
        echo "Ошибка: Название папок должно быть не более 7 символов."
        exit 1
    fi
}

# Проверяем имя файла
checkFileName() {
    if [[ "$1" =~ ^[a-zA-Z_]{1,7}\.[a-zA-Z]{1,3}$ ]]; then
        fileNames="$1"
    else
        echo "Ошибка: Неверный формат имени файла."
        exit 1
    fi
}

# Проверяем размер файла
checkFileSize() {
    if [[ "${1:(-2)}" == "Mb" && "${1:0:(-2)}" =~ ^[0-9]+$ && "${1:0:(-2)}" -ge 1 && "${1:0:(-2)}" -le 100 ]]; then
        fileSize="$1"
    else
        echo "Ошибка: Укажите размер файла в Mb (от 1 до 100)."
        exit 1
    fi
}
