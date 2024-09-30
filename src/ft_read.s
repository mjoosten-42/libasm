extern __errno_location

global ft_read

section .text

ft_read:
	enter	8, 0
	mov		rax, 0
	syscall	
	cmp		rax, 0
	js		.error
.end:
	leave
	ret	
.error:
	neg		rax
	push	rax
	call	__errno_location
	pop		QWORD [rax]
	mov		rax, -1		
	jmp		.end
