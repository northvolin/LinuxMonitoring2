#!/bin/bash

# Функция для генерации случайного URL-запроса
generate_url() {
    local -a urls=(
        "/home"
        "/about"
        "/contact"
        "/products"
        "/services"
    )
    echo "${urls[$RANDOM % ${#urls[@]}]}"
}

