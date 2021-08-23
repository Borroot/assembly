%ifndef READ_
%define READ_

%include "constants.asm"
%include "macros.asm"
%include "exit.asm"

section .data
	msg_move_x: db "Player X, please make a move (1-9): "
	msg_move_x_len: equ $-msg_move_x

	msg_move_o: db "Player O, please make a move (1-9): "
	msg_move_o_len: equ $-msg_move_o

	msg_invalid_input: db `Please provide a valid number (1-9).\n`
	msg_invalid_input_len: equ $-msg_invalid_input

section .bss
	buffer: resb 1

section .text
read_input:
	mov rbx, 0    ; keeps length of input
	mov input, 0  ; keeps last read char

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

	mov input, [buffer]  ; save previous char
	jmp read_char

read_process:
	cmp rbx, 2  ; input should be [1-9]\n so 2
	jne read_error
	cmp input, "1"
	jl read_error
	cmp input, "9"
	jg read_error
	sub input, "1"  ; convert char to number
	ret

read_error:
	write msg_invalid_input, msg_invalid_input_len
	jmp read_input

%endif ; READ_
