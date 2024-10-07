global ft_strcmp

section .text

ft_strcmp:
	; rdi = const char *s1
	; rsi = const char *s2
	enter	0, 0
	mov		rax, 0
	mov		rcx, 0	; size_t i = 0
.loop:
	mov		al, [rdi + rcx]			; move byte and zerofill
	sub		al, [rsi + rcx]			; compare characters
	jnz		.end
	cmp		BYTE [rdi + rcx], 0		; check null-terminator
	je		.end
	inc		rcx
	jmp		.loop
.end:
	movsx	rax, al					; move sign-extended
	leave
	ret

