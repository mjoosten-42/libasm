extern malloc
extern ft_strlen
extern ft_strcpy

global ft_strdup

section .text

; rdi = const char *str
ft_strdup:
	push	rbx				; str
	mov		rbx, rdi

	call	ft_strlen
	lea		rdi, [rax + 1]
	call	malloc wrt ..plt
	cmp		rax, 0
	jz		.end
	mov		rdi, rax
	mov		rsi, rbx
	call	ft_strcpy
.end:
	pop		rbx
	ret
