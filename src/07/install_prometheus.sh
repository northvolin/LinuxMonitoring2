#!/bin/bash

echo "Установка Prometheus..."
# Скачивание и распаковка Prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.30.3/prometheus-2.30.3.linux-amd64.tar.gz
tar xvf prometheus-2.30.3.linux-amd64.tar.gz

# Перемещение файлов Prometheus в нужные директории
cd prometheus-2.30.3.linux-amd64/
sudo cp prometheus promtool /usr/local/bin/
sudo mkdir -p /etc/prometheus
sudo mkdir -p /var/lib/prometheus
sudo cp -r consoles/ console_libraries/ /etc/prometheus/
sudo cp prometheus.yml /etc/prometheus/prometheus.yml

# Очистка
cd ..
rm prometheus-2.30.3.linux-amd64.tar.gz
rm -rf prometheus-2.30.3.linux-amd64

echo "Prometheus установлен."
