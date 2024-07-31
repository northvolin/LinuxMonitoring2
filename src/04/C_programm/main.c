#include <stdio.h>

#include "log_generator.h"

int main() {
  char start_date[11], end_date[11];
  printf("Введите начальную дату (YYYY-MM-DD): ");
  scanf("%10s", start_date);
  printf("Введите конечную дату (YYYY-MM-DD): ");
  scanf("%10s", end_date);

  generate_logs(start_date, end_date);

  printf("Генерация логов завершена.\n");
  return 0;
}
