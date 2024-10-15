global ft_list_remove_if

extern free

section .text

;void ft_list_remove_if(t_list **lst, void *data, int (*cmp)(), void
		;(*free)(void *));
ft_list_remove_if:
	enter	0, 0
	
	push	rbx			; **lst
	push	r12			; data
	push	r13			; cmp
	push	r14			; current
	push	r15			; prev

	mov		rbx, rdi
	mov		r12, rsi
	mov		r13, rdx
	mov		r14, [rdi]	; *lst
	xor		r15, r15

	push	rcx			; save free_fct on stack
.loop:
	test	r14, r14
	jz		.end

	mov		rdi, [r14 + 8]
	mov		rsi, r12
	call	r13
	test	eax, eax
	jnz		.continue
	
	mov		rdi, r15
	test	r15, r15
	cmovz	rdi, rbx
	mov		rsi, r14
	mov		rdx, [rsp + 8]
	mov		r14, [rdi]
	call	remove
	jmp		.loop
.continue:
	mov		r15, r14
	mov		r14, [r14]
	jmp		.loop

.end:
	pop		rcx
	pop		r15
	pop		r14
	pop		r13
	pop		r12
	pop		rbx

	leave
	ret

; void remove(t_list **prev, t_list *delete, void (*free)(void *))
remove:
	enter	0, 0

	push	rdi
	push	rsi
	mov		rdi, [rsi + 8]
	call	rdx
	pop		rsi
	pop		rdi
	mov		rcx, [rsi]
	mov		rdx, [rdi]
	mov		[rcx], rdx
	call	free

	leave
	ret
