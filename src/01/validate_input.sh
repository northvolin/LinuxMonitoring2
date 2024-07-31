#!/bin/bash

# Основная функция проверки входных параметров
validateInput() {
    checkArguments "$@"
    checkAbsolutePath "$1"
    checkSubfoldersCount "$2"
    checkFoldersName "$3"
    checkFilesCount "$4"
    checkFileName "$5"
    checkFileSize "$6"
}

# Проверяем количество параметров
checkArguments() {
    if [ $# -ne 6 ]; then
        echo "Ошибка: Введите 6 аргументов для запуска!"
        exit 1
    fi
}

# Проверяем корректность абсолютного пути
checkAbsolutePath() {
    if [ -d "$1" ]; then
        absolutePath="$1"
    else
        echo "Ошибка: Директория не существует!"
        read -p "Создать директорию $1? (y/n) " answer
        if [[ "$answer" =~ ^[Yy]$ ]]; then
            sudo mkdir -p "$1"
            if [ -d "$1" ]; then
                absolutePath="$1"
            else
                echo "Не удалось создать директорию! Укажите абсолютный путь."
                exit 1
            fi
        else
            exit 1
        fi
    fi
}

# Проверяем количество вложенных папок
checkSubfoldersCount() {
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        foldersNumber="$1"
    else
        echo "Ошибка: Введите количество вложенных папок."
        exit 1
    fi
}

# Проверяем название папок
checkFoldersName() {
    if [[ ${#1} -le 7 && "$1" =~ ^[a-zA-Z_]+$ ]]; then
        foldersName="$1"
    else
        echo "Ошибка: Название папок должно быть не более 7 символов."
        exit 1
    fi
}

# Проверяем количество файлов в каждой папке
checkFilesCount() {
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        numberFiles="$1"
    else
        echo "Ошибка: Введите количество файлов в папке."
        exit 1
    fi
}

# Проверяем название файлов
checkFileName() {
    if [[ "$1" =~ ^[a-zA-Z_]{1,7}\.[a-zA-Z]{1,3}$ ]]; then
        fileNames="$1"
    else
        echo "Ошибка: Неверный формат имени файла."
        exit 1
    fi
}

# Проверяем размер файлов
checkFileSize() {
    if [[ "${1:(-2)}" == "kb" && "${1:0:(-2)}" =~ ^[0-9]+$ && "${1:0:(-2)}" -ge 1 && "${1:0:(-2)}" -le 100 ]]; then
        fileSize="$1"
    else
        echo "Ошибка: Укажите размер файла в kb (от 1 до 100)."
        exit 1
    fi
}
