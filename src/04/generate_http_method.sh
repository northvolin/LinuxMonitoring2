#!/bin/bash

# Функция для генерации случайного HTTP-метода
generate_http_method() {
    local -a methods=("GET" "POST" "PUT" "PATCH" "DELETE")
    echo "${methods[$RANDOM % ${#methods[@]}]}"
}
