#!/bin/bash

# Функция для генерации случайного кода ответа HTTP
# Возможные коды ответа:
# 200 - OK
# 201 - Created
# 400 - Bad Request
# 401 - Unauthorized
# 403 - Forbidden
# 404 - Not Found
# 500 - Internal Server Error
# 501 - Not Implemented
# 502 - Bad Gateway
# 503 - Service Unavailable
generate_status_code() {
    local -a codes=(200 201 400 401 403 404 500 501 502 503)
    echo "${codes[$RANDOM % ${#codes[@]}]}"
}
