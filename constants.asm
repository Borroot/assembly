%ifndef CONSTANTS_
%define CONSTANTS_

%define cells_x r15w
%define cells_o r14w

%define char r12b    ; to be written
%define onturn r13b  ; x if 0, o if 1

section .data
	msg_move_x: db "Player X, please make a move (1-9): "
	msg_move_x_len: equ $-msg_move_x

	msg_move_o: db "Player O, please make a move (1-9): "
	msg_move_o_len: equ $-msg_move_o

	msg_win_x: db `Player X won!\n`
	msg_win_x_len: equ $-msg_win_x

	msg_win_o: db `Player X won!\n`
	msg_win_o_len: equ $-msg_win_o

	msg_draw: db `It's a draw!\n`
	msg_draw_len: equ $-msg_draw

	msg_cell_occupied: db `Please choose an empty cell.\n`
	msg_cell_occupied_len: equ $-msg_cell_occupied

	msg_invalid_input: db `Please provide a valid number (1-9).\n`
	msg_invalid_input_len: equ $-msg_invalid_input

	symbol_x: db "X"
	symbol_o: db "O"
	symbol_empty: db "."
	symbol_newline: db `\n`

%endif ; CONSTANTS_
