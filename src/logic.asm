%ifndef LOGIC_
%define LOGIC_

%include "constants.asm"
%include "macros.asm"
%include "exit.asm"

%macro checkwin 1
	mov ax, bx
	and ax, %1
	cmp ax, %1
	je won
%endmacro

section .data
	msg_win_x: db `Player X won!\n`
	msg_win_x_len: equ $-msg_win_x

	msg_win_o: db `Player O won!\n`
	msg_win_o_len: equ $-msg_win_o

	msg_draw: db `It's a draw!\n`
	msg_draw_len: equ $-msg_draw

section .text
logic:
	cmp onturn, 0  ; x if 0, o if 1
	jne check_o

	mov ax, cells_x
	jmp check

	check_o:
	mov ax, cells_o

check:
	call win
	call draw
	ret

draw:
	mov ax, cells_x
	or ax, cells_o
	cmp ax, 111111111b
	jne nodraw

	write msg_draw, msg_draw_len
	jmp exit

	nodraw: ret

win:
	mov bx, ax  ; backup

	; horizontal
	checkwin 000000111b
	checkwin 000111000b
	checkwin 111000000b

	; vertical
	checkwin 001001001b
	checkwin 010010010b
	checkwin 100100100b

	; diagonal
	checkwin 100010001b
	checkwin 001010100b

	ret

won:
	cmp onturn, 0  ; x if 0, o if 1
	jne won_o

	write msg_win_x, msg_win_x_len
	jmp exit

	won_o:
	write msg_win_o, msg_win_o_len
	jmp exit

%endif ; LOGIC_
