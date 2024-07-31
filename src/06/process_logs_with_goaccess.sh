#!/bin/bash

process_logs_with_goaccess() {
    local sort_choice="$1"
    local log_file_path="$2"

    if ! command -v goaccess &>/dev/null; then
        echo "GoAccess не установлен. Пожалуйста, установите GoAccess и повторите попытку."
        exit 1
    fi

    local report_path="/var/www/html/nginx_log_report.html"

    case "$sort_choice" in
        1) goaccess "$log_file_path" -o "$report_path" --log-format=COMBINED --real-time-html --sort-panel=REQUESTS ;;
        2) goaccess "$log_file_path" -o "$report_path" --log-format=COMBINED --real-time-html --sort-panel=VISITORS ;;
        3) goaccess "$log_file_path" -o "$report_path" --log-format=COMBINED --real-time-html --sort-panel=4XX ;;
        4) goaccess "$log_file_path" -o "$report_path" --log-format=COMBINED --real-time-html --sort-panel=5XX ;;
        *) echo "Ошибка: Неверный метод обработки логов." && exit 1 ;;
    esac

    if command -v python3 &>/dev/null; then
        python3 -m http.server --directory /var/www/html/
        echo "Отчёт доступен по адресу http://localhost:8000/nginx_log_report.html"
    elif command -v python &>/dev/null; then
        cd /var/www/html/ && python -m SimpleHTTPServer
        echo "Отчёт доступен по адресу http://localhost:8000/nginx_log_report.html"
    else
        echo "Python не установлен. Отчёт сгенерирован, но сервер не запущен."
    fi
}
