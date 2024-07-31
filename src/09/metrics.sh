#!/bin/bash

# Получение информации о загрузке ЦПУ
cpu=$(top -b -n1 | head -3 | tail -1 | awk '{print $2}')
# Получение информации о свободной памяти
mem_free=$(top -b -n1 | head -4 | tail -1 | awk '{print $6}')
# Получение информации об использованной памяти
mem_used=$(top -b -n1 | head -4 | tail -1 | awk '{print $8}')
# Получение информации о кэшированной памяти
mem_cache=$(top -b -n1 | head -4 | tail -1 | awk '{print $10}')
# Получение информации об использованном пространстве на диске
disk_used=$(df / | tail -n1 | awk '{print $3}')
# Получение информации о доступном пространстве на диске
disk_available=$(df / | tail -n1 | awk '{print $4}')

# Вывод метрик в формате, пригодном для Prometheus
echo "# TYPE my_cpu_usage gauge"
echo "my_cpu_usage $cpu"
echo "# TYPE my_mem_free gauge"
echo "my_mem_free $mem_free"
echo "# TYPE my_mem_used gauge"
echo "my_mem_used $mem_used"
echo "# TYPE my_mem_cache gauge"
echo "my_mem_cache $mem_cache"
echo "# TYPE my_disk_used gauge"
echo "my_disk_used $disk_used"
echo "# TYPE my_disk_available gauge"
echo "my_disk_available $disk_available"
