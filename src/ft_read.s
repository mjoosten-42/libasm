extern __errno_location

global ft_read

section .text

ft_read:
	mov		rax, 0	; read
	syscall	
	test	rax, rax
	jns		.end
	
	; error
	neg		rax
	push	rax
	call	__errno_location wrt ..plt
	pop		QWORD [rax]
	mov		rax, -1

.end:
	ret	
