global ft_strlen

; rdi = const char *str
ft_strlen:
	pxor		xmm0, xmm0
	xor			rax, rax
	xor			rcx, rcx
.loop:
	add			rax, rcx
	pcmpistri	xmm0, oword [rdi + rax], 0b00001000
	jnz			.loop
	add			rax, rcx
	ret
