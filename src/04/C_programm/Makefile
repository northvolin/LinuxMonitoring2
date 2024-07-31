# Определение компилятора
CC = gcc -Wall -Werror -Wextra

CFLAGS = -g -std=c11

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
  	OPEN_CMD = xdg-open
	ADD_LIB = -lcheck -lsubunit -lm -lrt -lpthread -D_GNU_SOURCE
endif

ifeq ($(UNAME_S),Darwin)
	OPEN_CMD = open
	ADD_LIB = -lcheck
endif


# Объектные файлы
OBJS=main.o helpers.o log_generator.o

# Цель по умолчанию
all: log_generator

# Цель для сборки исполнимого файла
log_generator: $(OBJS)
	$(CC) $(CFLAGS) -o log_generator $(OBJS)

# Зависимости для объектных файлов
main.o: main.c log_generator.h
	$(CC) $(CFLAGS) -c main.c

helpers.o: helpers.c helpers.h
	$(CC) $(CFLAGS) -c helpers.c

log_generator.o: log_generator.c log_generator.h helpers.h
	$(CC) $(CFLAGS) -c log_generator.c

style:
	@clang-format -style=Google -n *.c *.h ../*.sh ../../0*/*.sh

clean:
	@-rm -rf *.o *.gcno *.gcda *.info *.gcov *.a *.dSYM log_generator

all_clean: clean
	@ -rm -rf *.o *.gcno *.gcda *.info *.gcov *.a log_generator

.PHONY:	log_generator