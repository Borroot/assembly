global _start

section .bss
	buffer: resb 1        ; buffer of 1 byte size
	buflen: equ $-buffer  ; dynamic buffer length variable

section .text
_start:

echo:
	mov rax, 0       ; syscall read
	mov rdi, 0       ; stdin
	lea rsi, buffer  ; buffer
	mov rdx, buflen  ; buffer length
	syscall

	cmp rax, 0       ; return value of read (number of bytes read)
	je done          ; jump if return value is 0

	mov rax, 1       ; syscall write
	mov rdi, 1       ; stdout
	lea rsi, buffer  ; buffer
	mov rdx, buflen  ; buffer length
	syscall

	jmp echo

done:
	mov rax, 60  ; syscall exit
	mov rdi, 0   ; exit success
	syscall
