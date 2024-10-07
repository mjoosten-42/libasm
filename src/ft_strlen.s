global ft_strlen

section .text

; rdi = const char *str
ft_strlen:
	enter	0, 0	
	mov		rax, rdi
	.loop:
	cmp		BYTE [rax], 0
	jz		.end				
	inc		rax
	jmp		.loop
	.end:
	sub		rax, rdi
	leave
	ret
