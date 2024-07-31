#include "log_generator.h"

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "helpers.h"

void generate_logs(const char* start_date, const char* end_date __attribute__((unused))) {
  // Генерация дат в указанном диапазоне
  // Здесь нужно добавить логику для обработки дат

  // Пример создания одного файла лога на один день
  int num_entries =
      rand() % 901 + 100;  // Случайное количество записей от 100 до 1000
  for (int i = 0; i < num_entries; ++i) {
    char* ip = generate_ip();
    char* status_code = generate_status_code();
    char* method = generate_http_method();
    char* date = generate_date(
        start_date);  // Замените start_date на соответствующую дату
    char* url = generate_url();
    char* user_agent = generate_user_agent();

    printf("%s - - [%s +0000] \"%s %s HTTP/1.1\" %s - \"%s\"\n", ip, date,
           method, url, status_code, user_agent);
  }
}
