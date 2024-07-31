#!/bin/bash


create_dashboard() {
    echo "Создание дашборда Grafana..."

    # JSON содержимое дашборда
    dashboard_json='{
      "dashboard": {
        "id": null,
        "title": "New Dashboard",
        "panels": [
          {
            "title": "CPU Usage",
            "type": "graph",
            "targets": [
              { "expr": "cpu_usage" }
            ]
          },
          {
            "title": "Memory Usage",
            "type": "graph",
            "targets": [
              { "expr": "memory_usage" }
            ]
          }
          // Добавьте здесь другие панели
        ]
      },
      "overwrite": true
    }'

    # Отправка запроса на создание дашборда
    curl -X POST -H "Content-Type: application/json" -d "$dashboard_json" http://admin:admin@localhost:3000/api/dashboards/db
}

