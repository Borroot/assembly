global _start

%include "constants.asm"
%include "write.asm"
%include "move.asm"
%include "logic.asm"

section .text
_start:
	mov cells_x, 000000000b
	mov cells_o, 000000000b
	mov onturn,  0

	call write_board

loop:
	call move
	call write_board
	call logic

	xor onturn, 1
	jmp loop
