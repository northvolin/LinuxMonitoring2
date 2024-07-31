#!/bin/bash

# Установка Prometheus
./install_prometheus.sh

# Установка Grafana
./install_grafana.sh

# Настройка дашборда Grafana
./setup_dashboard.sh

# Запуск стресс-теста
./stress_test.sh
echo "Установка и настройка завершены."
