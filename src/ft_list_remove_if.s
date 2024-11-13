global ft_list_remove_if

extern free

section .text

;void ft_list_remove_if(t_list **lst, void *data, int (*cmp)(), void
		;(*free)(void *));
ft_list_remove_if:
	push	rbx			; prev
	push	r12			; data
	push	r13			; cmp
	push	r14			; curr
	push	r15			; free_fct/next

	lea		rbx, [rdi - 8] ; prev = lst
	mov		r12, rsi
	mov		r13, rdx
	mov		r14, [rdi]	; curr = *lst
	mov		r15, rcx
.loop:
	test	r14, r14
	jz		.end

	; compare
	mov		rdi, [r14 + 0]
	mov		rsi, r12
	call	r13				; cmp(curr->data, data)
	test	eax, eax
	jnz		.continue

	; remove
	mov		rdi, [r14 + 0]	; curr->data
	call	r15				; free_fct(curr->data)

	push	r15				; free_fct
	mov		r15, [r14 + 8]	; next = curr->next
	mov		rdi, r14
	call	free wrt ..plt

	mov		r14, r15		; cur = next
	pop		r15
	mov		[rbx + 8], r14	; prev->next = cur
	jmp		.loop

.continue:
	mov		rbx, [rbx + 8]	; prev = prev->next
	mov		r14, [r14 + 8]	; curr = curr->next
	jmp		.loop

.end:
	pop		r15
	pop		r14
	pop		r13
	pop		r12
	pop		rbx
	ret


