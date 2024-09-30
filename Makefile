NAME 	= libasm.a
ASM		= nasm
AFLAGS	= -f elf64
CC 		= gcc
CFLAGS  = -Wall -Werror -Wextra -no-pie -e main
SRC_DIR = src
OBJ_DIR = obj
ASM_EXT = s

#export MAKEFLAGS = "-j 8"

include make/sources.mk

OBJECTS = $(patsubst $(SRC_DIR)/%,$(OBJ_DIR)/%,$(SOURCES:.$(ASM_EXT)=.o))

DEBUG ?= 1

ifeq ($(DEBUG), 1)
	AFLAGS += -g
	CFLAGS += -g -O0 
endif

all: $(NAME)

$(NAME): $(OBJECTS)
	ar -crs $@ $^ 

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.$(ASM_EXT) | $(OBJ_DIR)
	$(ASM) $(AFLAGS) $< -o $@

$(OBJ_DIR):
	mkdir -p $@

clean:
	$(RM) -r $(OBJ_DIR)
	$(RM) a.out

fclean: clean
	$(RM) $(NAME) $(HOST)

re:
	make fclean
	make all

test: $(NAME) main.c
	$(CC) $(CFLAGS) main.c $(NAME) && ./a.out

files:
	./make/make_sources.sh

print: 
	@echo "---SOURCES: $(SOURCES)" | xargs -n1
	@echo "---OBJECTS: $(OBJECTS)" | xargs -n1

format: files
	clang-format -i $(SOURCES) $(HEADERS)

scan: clean
	scan-build make

.PHONY: all test clean fclean re files print format scan

-include $(OBJECTS:.o=.d)
