%ifndef MACROS_
%define MACROS_

%macro write 2
	mov rax, 0x01  ; syscall write
	mov rdi, 1     ; stdout
	lea rsi, %1    ; buffer
	mov rdx, %2    ; buffer length
	syscall
%endmacro

%endif ; MACROS_
