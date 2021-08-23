LFLAGS = -m elf_x86_64
AFLAGS = -f elf64 -g

ASM = nasm

SRC_FILES = $(wildcard *.asm)
OBJ_FILES = $(patsubst %.asm, %.o, $(SRC_FILES))

TARGETS = tictactoe

all: $(TARGETS)

tictactoe: % : $(OBJ_FILES)
	@echo -e "LINK\t$@"
	@$(LD) $(LFLAGS) -o $@ $^

%.o: %.asm
	@echo -e "ASM\t$@"
	@$(ASM) $(AFLAGS) $^

clean:
	@rm -f *.o $(TARGETS)

re: clean all

.PHONY: all clean re
