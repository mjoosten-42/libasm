global ft_list_remove_if

extern free

section .text

;void ft_list_remove_if(t_list **lst, void *data, int (*cmp)(), void
		;(*free)(void *));
ft_list_remove_if:
	enter	0, 0
	
	push	rbx			; lst
	push	r12			; data
	push	r13			; cmp
	push	r14			; current
	push	r15			; free_fct/next

	mov		rbx, rdi
	mov		r12, rsi
	mov		r13, rdx
	mov		r14, [rdi]	; *lst
	mov		r15, rcx
.loop:
	test	r14, r14
	jz		.end

	mov		rdi, [r14 + 8]
	mov		rsi, r12
	call	r13
	test	eax, eax
	jnz		.continue

	mov		rdi, [r14 + 8]	; cur->data
	call	r15				; free_fct(cur->data)

	push	r15				; free_fct
	mov		r15, [r14 + 0]	; next = cur->next
	mov		rdi, r14
	call	free wrt ..plt

	mov		r14, r15		; cur = next
	pop		r15
	mov		[rbx + 0], r14
	jmp		.loop

.continue:
	mov		rbx, [rbx + 0]
	mov		r14, [r14 + 0]
	jmp		.loop

.end:
	pop		r15
	pop		r14
	pop		r13
	pop		r12
	pop		rbx

	leave
	ret


