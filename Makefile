SRC_DIR = src
OBJ_DIR = obj

SRC_FILES = $(wildcard $(SRC_DIR)/*.asm)
OBJ_FILES = $(patsubst $(SRC_DIR)/%.asm, $(OBJ_DIR)/%.o, $(SRC_FILES))

LFLAGS = -m elf_x86_64
AFLAGS = -f elf64 -I $(SRC_DIR)/ -g

ASM = nasm

TARGETS = tictactoe

all: $(TARGETS)

tictactoe: % : $(OBJ_FILES)
	@echo -e "LINK\t$@"
	@$(LD) $(LFLAGS) -o $@ $^

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.asm $(SRC_FILES)
	@echo -e "ASM\t$@"
	@mkdir -p $(OBJ_DIR)
	@$(ASM) $(AFLAGS) -o $@ $<

clean:
	@rm -rf $(OBJ_DIR) $(TARGETS)

re: clean all

.PHONY: all clean re
