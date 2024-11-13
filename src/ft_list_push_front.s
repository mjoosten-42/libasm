global ft_list_push_front

extern malloc

section .text

ft_list_push_front:
	enter	0, 0

	push	rbx
	mov		rbx, rdi

	mov		rdi, rsi
	call	ft_create_elem
	test	rax, rax
	jz		.end
	cmp		QWORD [rbx], 0
	jz		.L1
	mov		rcx, [rbx]
	mov		[rax + 8], rcx
.L1:
	mov		[rbx], rax
.end:
	pop		rbx
	leave
	ret

ft_create_elem:
	enter	0, 0

	push	rbx
	mov		rbx, rdi
	
	mov		rdi, 16
	call	malloc wrt ..plt
	test	rax, rax
	jz		.end
	mov		QWORD [rax + 8], 0
	mov		QWORD [rax + 0], rbx
.end:
	pop		rbx
	leave
	ret
