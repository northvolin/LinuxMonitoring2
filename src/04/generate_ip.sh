#!/bin/bash

# Функция для генерации случайного IP-адреса
generate_ip() {
    echo "$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256))"
}
