#!/bin/bash

# Запуск генерации структуры каталогов и файлов
startGeneration() {
    nameLen=${#foldersName}
    offset=$nameLen

    # Дополняем имя до 5 символов, если оно короче
    if [[ nameLen -lt 5 ]]; then
        offset=$((5 - nameLen))
    fi

    # Генерация директорий и файлов
    for (( i=offset; i<(foldersNumber+offset); i++ )); do
        dirPath=$(createDirectory $absolutePath $i)
        absolutePath=$dirPath

        for (( j=0; j<numberFiles; j++ )); do
            if [[ $(isDiskSpaceLow) == "true" ]]; then
                echo "Ошибка: Недостаточно места на диске."
                exit
            else
                createFile $dirPath $j
            fi
        done
    done
}

# Создание директории
createDirectory() {
    path=$absolutePath/$(generateFolderName $2)_$(getCurrentDate)
    sudo mkdir -p $path
    logCreation $path $(getCurrentDate)
    echo $path
}

# Создание файла
createFile() {
    folderPath=$1
    baseCharset=${fileNames%%.*}
    baselen=${#baseCharset}
    nameLen=$baselen
    if [[ nameLen -lt 5 ]]; then
        let "nameLen+=(5-nameLen)"
    fi
    let "nameLen+=j"

    fileName=$(generateFileName $nameLen)
    sudo fallocate -l ${fileSize^} $folderPath/$fileName
    logCreation $folderPath/$fileName $(getCurrentDate) $fileSize
}

# Получение текущей даты
getCurrentDate() {
    echo $(date +%d%m%y)
}

# Генерация имени для директории
generateFolderName() {
    str=$foldersName
    maxLen=$1
    for (( i=${#str}; i<maxLen; i++ )); do
        str="${str:0:1}${str}"
    done
    echo $str
}

# Генерация имени файла
generateFileName() {
    strFile=$fileNames
    extCharset=${strFile#*.}
    baseCharset=${strFile%%.*}
    base=$baseCharset
    baseMaxLen=$1

    for (( i=${#base}; i<baseMaxLen; i++ )); do
        base="${base:0:1}${base}"
    done

    echo "$base.$extCharset"_"$(getCurrentDate)"
}

# Проверка свободного места на диске
getFreeDiskSpace() {
    echo $(df / -BM | awk '{print $4}' | tail -n 1 | cut -d 'M' -f1)
}

# Проверка на недостаток места на диске
isDiskSpaceLow() {
    if [[ $(getFreeDiskSpace) -lt 1024 ]]; then
        echo "true"
    else
        echo "false"
    fi
}

# Логирование создания
logCreation() {
    fullPath=$1
    date=$2
    size=$3
    time=$(date +%H:%M:%S)

    line="$fullPath $date $time $size"

    sudo echo $line >> logfile.txt
}

# Финальное логирование
finalLog() {
    timeCompleted=$(date +%H:%M:%S)
    endTime=$(date +%s)
    executionTime=$((endTime - startTime))

    echo "Время начала работы скрипта: $(date '+%Y-%m-%d') $timeRunIn"
    echo "Время окончания: $(date '+%Y-%m-%d') $timeCompleted"
    echo "Общее время работы (секунды): $executionTime"

    echo "Время начала работы скрипта: $(date '+%Y-%m-%d') $timeRunIn" >> log.txt
    echo "Время окончания: $(date '+%Y-%m-%d') $timeCompleted" >> log.txt
    echo "Общее время работы (секунды): $executionTime" >> log.txt
}
