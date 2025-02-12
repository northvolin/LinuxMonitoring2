#!/bin/bash

# Установка готового дашборда в Grafana
echo "Установка готового дашборда в Grafana..."
./install_dashboard.sh

# Проверка, установлен ли iperf3
if ! command -v iperf3 &> /dev/null
then
    echo "Установка iperf3..."
    ./setup_iperf3.sh
else
    echo "iperf3 уже установлен."
fi

# Запуск тестов
echo "Запуск тестов..."
./run_tests.sh

# Инструкция пользователю о запуске iperf3 на другой виртуальной машине
echo "Пожалуйста, запустите iperf3 в режиме клиента на другой виртуальной машине для тестирования сети."

# Завершение
echo "Все процессы выполнены."
