; Use the following commands to inspect the machine code
; hexdump -C hello.nasm
; objdump -O hello.nasm

global _start

section .data
	msg: db "Hello world!", 0xa  ; db = declare bytes, 0xa = \n
	len: equ $-msg  ; current label offset - msg label address

section .text
_start:
	; write(1, msg, len) # 1 is stdout, the fd
	mov eax, 4  ; 4 = write()
	mov ebx, 1
	mov ecx, msg
	mov edx, len
	int 0x80  ; interrupt to signal kernel

	; exit(0)
	mov eax, 1  ; 1 = exit()
	mov ebx, 0
	int 0x80  ; interrupt to signal kernel
