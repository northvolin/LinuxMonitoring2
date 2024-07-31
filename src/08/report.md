## Установить готовый дашборд *Node Exporter Quickstart and Dashboard* с официального сайта **Grafana Labs**

Установим готовый дашборд `Node Exporter Quickstart and Dashboard` с официального сайта `https://grafana.com/grafana/dashboards/13978-node-exporter-quickstart-and-dashboard/` и добавим дашборд в Grafana: `Dashboards->Manage->Import`

## Провести те же тесты, что и в Части 7

Запустим bash-скрипт из `Part 2` 

![](/src/08/screenshots/1.png)


* Запустим команду
    ```
    stress -c 2 -i 1 -m 1 --vm-bytes 32M -t 60s
    ```
![](/src/08/screenshots/2.png)


## Запустить ещё одну виртуальную машину, находящуюся в одной сети с текущей. Запустить тест нагрузки сети с помощью утилиты **iperf3** Посмотреть на нагрузку сетевого интерфейса

* Первая машина выступает в роли сервера, выполним команду <br/>

    ```
     iperf3 -s
    ```
* Вторая машина выступает в роли клиента, выполним команду <br/>
    ```
     iperf3 -c 10.100.0.10
    ```
* Посмотрим на нагрузку сетевого интерфейса <br/>
  
![](/src/08/screenshots/3.png)