global ft_write

extern __errno_location

section .text

ft_write:
	mov		rax, 1	; write
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
