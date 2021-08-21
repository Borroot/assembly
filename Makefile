LFLAGS = -m elf_x86_64
AFLAGS = -f elf64

ASM = nasm

TARGETS = hello

all: $(TARGETS)

hello: % : %.o
	@echo -e "LINK\t$@"
	@$(LD) $(LFLAGS) -o $@ $^

%.o: %.asm
	@echo -e "ASM\t$@"
	@$(ASM) $(AFLAGS) $^

clean:
	@rm -f *.o $(TARGETS)

re: clean all

.PHONY: all clean re
