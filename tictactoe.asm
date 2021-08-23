global _start

%macro write 2
	mov rax, 0x01  ; syscall write
	mov rdi, 1     ; stdout
	lea rsi, %1    ; buffer
	mov rdx, %2    ; buffer length
	syscall
%endmacro

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

section .bss
	buffer: resb 1

section .text
_start:
	mov cells_x, 101010001b
	mov cells_o, 010100010b
	mov onturn,  0

	;call write_board
	call read_input
	jmp exit

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

read_input:
	mov rbx, 0  ; keeps length of input
	mov rcx, 0  ; keeps last read char

	cmp onturn, 0  ; ask player to input a move
	jne other_onturn

	write msg_move_x, msg_move_x_len
	jmp read_char
	other_onturn:
	write msg_move_o, msg_move_o_len

read_char:
	mov rax, 0x00    ; syscall read
	mov rdi, 0       ; stdin
	lea rsi, buffer
	mov rdx, 1       ; buffer length
	syscall

	cmp rax, 0
	je exit

	inc rbx

	mov rax, [buffer]
	cmp rax, `\n`
	je read_process

	mov r8, [buffer]  ; save previous char
	jmp read_char

read_process:
	cmp rbx, 2  ; input should be [1-9]\n so 2
	jne read_error
	cmp r8, "1"
	jl read_error
	cmp r8, "9"
	jg read_error
	ret

read_error:
	write msg_invalid_input, msg_invalid_input_len
	jmp read_input

exit:
	mov rax, 0x3c  ; syscall exit
	mov rdi, 0     ; exit success
	syscall
