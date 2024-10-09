global ft_list_size

section .text

ft_list_size:
	enter	0, 0
	xor		rax, rax
.loop:
	test	rdi, rdi
	jz		.end
	inc		rax
	mov		rdi, [rdi]
	jmp		.loop
.end:
	leave
	ret

