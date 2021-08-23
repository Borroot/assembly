global _start

%include "constants.asm"
%include "write.asm"
%include "move.asm"
%include "exit.asm"

section .text
_start:
	mov cells_x, 000000000b
	mov cells_o, 000000000b
	mov onturn,  0

loop:
	call write_board
	call move

	xor onturn, 1
	jmp loop
