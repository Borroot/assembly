%ifndef MOVE_
%define MOVE_

%include "constants.asm"
%include "read.asm"

section .data
	msg_cell_occupied: db `Please choose an empty cell.\n`
	msg_cell_occupied_len: equ $-msg_cell_occupied

section .text
occupied:
	write msg_cell_occupied, msg_cell_occupied_len

move:
	call read_input

	; check if the cell is empty
	mov ax, cells_x
	or ax, cells_o

	mov cl, input
	mov bx, 1
	shl bx, cl

	and ax, bx
	cmp ax, 0
	jne occupied

	; update the board
	cmp onturn, 0  ; x if 0, o if 1
	jne other

	mov ax, cells_x
	or ax, bx
	mov cells_x, ax
	ret

	other:
	mov ax, cells_o
	or ax, bx
	mov cells_o, ax
	ret

%endif ; MOVE_
