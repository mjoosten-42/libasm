extern malloc
extern ft_strlen
extern ft_strcpy

global ft_strdup

section .text

; rdi = const char *str
ft_strdup:
	enter	0, 0
	push	rdi				; save str
	call	ft_strlen
	lea		rdi, [rax + 1]	; same as inc + mov
	call	malloc
	cmp		rax, 0	
	jz		.end
	mov		rdi, rax
	pop		rsi
	call	ft_strcpy
.end:
	leave
	ret
