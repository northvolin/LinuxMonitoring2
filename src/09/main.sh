#!/bin/bash

# Обновление конфигурации Prometheus
sudo cp prometheus.yml /etc/prometheus/prometheus.yml # Копирование конфигурационного файла Prometheus
systemctl restart prometheus.service # Перезапуск Prometheus для применения новой конфигурации

# Создание конфигурационного файла Nginx
touch index.html # Создание пустого файла index.html
path=$(pwd) # Получение текущего пути директории

# Написание конфигурационного файла Nginx
echo "events {
    worker_connections  1024;
}
http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';
    access_log  /var/log/nginx/access.log  main;
    server {
        listen 80;
        server_name test.nginx.com;
        root $path;
        index index.html;
    }
    sendfile        on;
    keepalive_timeout  65;
}" > nginx.conf

# Применение конфигурации Nginx
sudo cp nginx.conf /etc/nginx/nginx.conf # Копирование конфигурации в Nginx
sudo nginx -t # Проверка конфигурации Nginx
sudo systemctl restart nginx # Перезапуск Nginx

# Цикл для обновления HTML-страницы
while sleep 3 # Цикл выполняется каждые 3 секунды
do
    ./metrics.sh > index.html # Запуск скрипта info.sh и запись его вывода в index.html
done
