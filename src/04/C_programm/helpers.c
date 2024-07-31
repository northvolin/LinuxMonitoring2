#include "helpers.h"

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

char* generate_ip() {
  static char ip[16];
  sprintf(ip, "%d.%d.%d.%d", rand() % 256, rand() % 256, rand() % 256,
          rand() % 256);
  return ip;
}

char* generate_status_code() {
  static char* status_codes[] = {"200", "201", "400", "401", "403",
                                 "404", "500", "501", "502", "503"};
  return status_codes[rand() % 10];
}

char* generate_http_method() {
  static char* methods[] = {"GET", "POST", "PUT", "PATCH", "DELETE"};
  return methods[rand() % 5];
}

char* generate_date(const char* base_date) {
  static char date[20];
  // Генерация случайного времени в рамках указанного дня
  sprintf(date, "%s:%02d:%02d:%02d", base_date, rand() % 24, rand() % 60,
          rand() % 60);
  return date;
}

char* generate_url() {
  static char url[50];
  sprintf(url, "/path/to/resource/%d", rand() % 1000);
  return url;
}

char* generate_user_agent() {
  static char* user_agents[] = {
      "Mozilla",         "Google Chrome",       "Opera",
      "Safari",          "Internet Explorer",   "Microsoft Edge",
      "Crawler and bot", "Library and net tool"};
  return user_agents[rand() % 8];
}
