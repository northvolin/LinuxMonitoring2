#!/bin/bash

# Функция для генерации случайного агента пользователя (User-Agent)
generate_user_agent() {
    local -a agents=(
        "Mozilla"
        "Google Chrome"
        "Opera"
        "Safari"
        "Internet Explorer"
        "Microsoft Edge"
        "Crawler and bot"
        "Library and net tool"
    )
    echo "${agents[$RANDOM % ${#agents[@]}]}"
}
