#!/bin/bash

# Подключение внешних скриптов
source generate_ip.sh
source generate_status_code.sh
source generate_http_method.sh
source generate_date.sh
source generate_url.sh
source generate_user_agent.sh

# Функция для генерации одной записи лога
generate_log_entry() {
    local date="$1"
    echo "$(generate_ip) - - $(generate_date "$date") \"$(generate_http_method) $(generate_url) HTTP/1.1\" $(generate_status_code) $(($RANDOM % 5000 + 100)) \"-\" \"$(generate_user_agent)\""
}



# Запрос у пользователя дат для генерации логов
read -p "Введите начальную дату (YYYY-MM-DD): " start_date
read -p "Введите конечную дату (YYYY-MM-DD) или нажмите Enter для использования текущей даты: " end_date

# Если пользователь не ввел конечную дату, используем текущую дату
if [ -z "$end_date" ]; then
    end_date=$(date +%Y-%m-%d)
fi

# Проверка корректности дат
if ! date -d "$start_date" > /dev/null; then
    echo "Неверная начальная дата."
    exit 1
fi
if ! date -d "$end_date" > /dev/null; then
    echo "Неверная конечная дата."
    exit 1
fi

# Преобразование строковых дат в секунды с начала эпохи Unix
start_date_sec=$(date -d "$start_date" +%s)
end_date_sec=$(date -d "$end_date" +%s)

# Генерация логов в заданном диапазоне дат
current_date_sec=$start_date_sec
while [ "$current_date_sec" -le "$end_date_sec" ]; do
    current_date=$(date -d @"$current_date_sec" +%Y-%m-%dT%H:%M:%S.%3N)
    log_file="nginx_log_$current_date.log"
    echo "Генерация лога за $current_date в файл $log_file"
    entries_count=$((RANDOM % 901 + 100)) # Случайное число записей от 100 до 1000
    for ((i = 0; i < "$entries_count"; i++)); do
        generate_log_entry "$current_date" >>"$log_file"
    done
    # Переход к следующему дню
    current_date_sec=$((current_date_sec + 86400)) # Добавляем 24 часа в секундах
done
echo "Генерация логов завершена."
