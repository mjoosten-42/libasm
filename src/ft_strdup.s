extern malloc
extern strlen
extern strcpy

global ft_strdup

section .text

; rdi = const char *str
ft_strdup:
	enter	0, 0
	push	rdi				; save str
	call	strlen wrt ..plt
	lea		rdi, [rax + 1]	; same as inc + mov
	sub		rsp, 8			; align sp to 16 for malloc
	call	malloc wrt ..plt
	add		rsp, 8			; 
	cmp		rax, 0
	jz		.end
	mov		rdi, rax
	pop		rsi
	call	strcpy wrt ..plt
.end:
	leave	
	ret
