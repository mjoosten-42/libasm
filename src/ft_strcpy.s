global ft_strcpy

section .text

; rdi = char *dest
; rsi = const char *src
ft_strcpy:
	mov		rcx, 0
	mov		rax, rdi
.loop:
	mov		dh, [rsi + rcx]
	mov		[rdi + rcx], dh
	cmp		dh, 0
	jz		.end
	inc		rcx
	jmp		.loop
.end:
	ret
	
