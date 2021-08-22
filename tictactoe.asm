global _start

%macro write 2
	mov rax, 0x01  ; syscall write
	mov rdi, 1     ; stdout
	lea rsi, %1
	mov rdx, %2
	syscall
%endmacro

%define cells_x bx  ; or r15w
%define cells_o cx  ; or r14w

%define char r12b    ; to be written
%define onturn r13b  ; x if 0, o if 1

section .data
	msg_move_x: db "Player X, please make a move (1-9): "
	msg_move_x_len: equ $-msg_move_x

	msg_move_o: db "Player O, please make a move (1-9): "
	msg_move_o_len: equ $-msg_move_o

	msg_win_x: db "Player X won!"
	msg_win_x_len: equ $-msg_win_x

	msg_win_o: db "Player X won!"
	msg_win_o_len: equ $-msg_win_o

	msg_draw: db "It's a draw!"
	msg_draw_len: equ $-msg_draw

	msg_cell_occupied: db "Please choose an empty cell."
	msg_cell_occupied_len: equ $-msg_cell_occupied

	msg_invalid_input: db "Please provide a valid number (1-9)."
	msg_invalid_input_len: equ $-msg_invalid_input

section .bss
	buffer: resb 1

section .text
_start:
	mov cells_x, 0x00
	mov cells_o, 0x00
	mov onturn,  0

	write msg_move_x, msg_move_x_len

read_char:
	mov rax, 0x00    ; syscall read
	mov rdi, 0       ; stdin
	lea rsi, buffer
	mov rdx, 1       ; buffer length
	syscall

	cmp rax, 0
	je done

	write buffer, 1

	mov rax, [buffer]
	cmp rax, `\n`
	je done

	jmp read_char

done:
	mov rax, 0x3c  ; syscall exit
	mov rdi, 0     ; exit success
	syscall
