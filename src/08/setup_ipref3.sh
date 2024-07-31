#!/bin/bash

# Установка iperf3
echo "Установка iperf3..."
sudo apt-get install -y iperf3

# Запуск iperf3 в режиме сервера на текущей машине
echo "Запуск iperf3 в режиме сервера..."
iperf3 -s &

# Подключение к серверу iperf3 на другой машине
echo "Введите IP-адрес второй виртуальной машины:"
read REMOTE_IP
iperf3 -c $REMOTE_IP
