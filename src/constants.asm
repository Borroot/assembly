%ifndef CONSTANTS_
%define CONSTANTS_

%define cells_x r15w
%define cells_o r14w

%define input r12b   ; move that was inputted
%define onturn r13b  ; x if 0, o if 1

section .data
	msg_win_x: db `Player X won!\n`
	msg_win_x_len: equ $-msg_win_x

	msg_win_o: db `Player X won!\n`
	msg_win_o_len: equ $-msg_win_o

	msg_draw: db `It's a draw!\n`
	msg_draw_len: equ $-msg_draw

%endif ; CONSTANTS_
