; Use the following commands to inspect the machine code
; hexdump -C hello.nasm
; objdump -O hello.nasm

global _start

section .data
	msg: db "Hello world!", 10  ; db = declare bytes, 10 = \n
	len: equ $-msg  ; current label offset - msg label address

section .text
_start:
	; write(1, msg, len) # 1 is stdout, the fd
	mov rax, 1  ; 1 = write()
	mov rdi, 1
	mov rsi, msg
	mov rdx, len
	syscall

	; exit(0)
	mov rax, 60  ; 60 = exit()
	mov rdi, 0
	syscall
