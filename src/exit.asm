%ifndef EXIT_
%define EXIT_

section .text
exit:
	mov rax, 0x3c  ; syscall exit
	mov rdi, 0     ; exit success
	syscall

%endif ; EXIT_
