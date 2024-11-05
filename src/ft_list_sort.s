global ft_list_sort

section .text

; void ft_list_sort(t_list **lst, int (*cmp)())
ft_list_sort:
	enter	0, 0

	push	rbx
	push	r12
	push	r13
	push	r14
	push	r15

	cmp		QWORD [rdi], 0	; if (!*lst)
	je		.end

	mov		rbx, rdi		; prev
	mov		r12, [rdi]		; current
	xor		r13, r13		; next
	mov		r14, rsi		; cmp
	mov		r15, rdi		; lst_cpy

.loop:
	cmp		QWORD [r12], 0	; while (cur->next)
	je		.end

	mov		r13, [r12]		; next = cur->next
	mov		rdi, [r12 + 8]
	mov		rsi, [r13 + 8]
	call	r14				; cmp(cur->data, next->data)
	test	eax, eax
	jle		.continue

	; swap
	mov		r8, [r13]		; after = next->next
	mov		[r13], r12		; next->next = cur
	mov		[r12], r8		; cur->next = after
	mov		[rbx], r13		; prev->next = next

	; start from beginning
	mov		r12, [r15]		; cur = *lst_cpy
	mov		rbx, r15		; lst = lst_cpy
	jmp		.loop			

.continue:
	mov		r12, [r12]		; cur = cur->next
	mov		rbx, [rbx]		; prev = prev->next
	jmp		.loop

.end:
	pop		r15
	pop		r14
	pop		r13
	pop		r12
	pop		rbx

	leave
	ret

