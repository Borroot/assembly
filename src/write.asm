%ifndef WRITE_
%define WRITE_

%include "constants.asm"
%include "macros.asm"

section .data
	symbol_x: db "X"
	symbol_o: db "O"
	symbol_empty: db "."
	symbol_newline: db `\n`

section .text
write_board:
	mov bx, 1 << 0
	call write_symbol
	mov bx, 1 << 1
	call write_symbol
	mov bx, 1 << 2
	call write_symbol
	write symbol_newline, 1

	mov bx, 1 << 3
	call write_symbol
	mov bx, 1 << 4
	call write_symbol
	mov bx, 1 << 5
	call write_symbol
	write symbol_newline, 1

	mov bx, 1 << 6
	call write_symbol
	mov bx, 1 << 7
	call write_symbol
	mov bx, 1 << 8
	call write_symbol
	write symbol_newline, 1

	ret

write_symbol:
	mov ax, cells_x
	and ax, bx
	cmp ax, 0
	jz other_symbol
	write symbol_x, 1
	ret

other_symbol:
	mov ax, cells_o
	and ax, bx
	cmp ax, 0
	jz empty_symbol
	write symbol_o, 1
	ret

empty_symbol:
	write symbol_empty, 1
	ret

%endif ; WRITE_
