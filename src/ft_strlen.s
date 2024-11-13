global ft_strlen

; rdi = const char *str
ft_strlen:
	xor			rcx, rcx
	pxor		xmm0, xmm0
	mov			rax, 0
.loop:
	add			rax, rcx
	pcmpistri	xmm0, oword [rdi + rax], 0b00001000
	jnz			.loop
	add			rax, rcx
	ret
