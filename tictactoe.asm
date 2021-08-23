global _start

%include "constants.asm"
%include "read.asm"
%include "write.asm"
%include "exit.asm"

section .text
_start:
	mov cells_x, 101010001b
	mov cells_o, 010100010b
	mov onturn,  0

	;call write_board
	call read_input
	jmp exit
