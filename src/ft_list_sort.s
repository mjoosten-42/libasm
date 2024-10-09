global ft_list_sort

extern ft_list_push_front
extern ft_list_size
extern qsort
extern malloc

section .text

ft_list_sort:
	enter	0, 0

	push	rbx
	push	r12
	push	r13
	push	r14

	mov		rbx, rdi		; **lst
	mov		r12, rsi		; (*cmp)
	mov		rdi, [rdi]
	call	ft_list_size
	mov		r13, rax		; lstsize
	mov		rdi, rax
	imul	rdi, 8			; len * sizeof(void *)
	call	malloc
	test	rax, rax
	jz		.end
	mov		r14, rax		; void* array[]	

; fill array with data
	xor		rcx, rcx
	mov		rdx, [rbx]		; current
.loop1:
	test	rdx, rdx
	jz		.sort
	mov		r8, [rdx + 8]		; current->data
	lea		r9, [r14 + 8 * rcx]
	mov		[r9], r8
	inc		rcx
	mov		rdx, [rdx]
	jmp		.loop1
.sort:
	mov		rdi, r14
	mov		rsi, r13
	mov		rdx, 8
	mov		rcx, r12
	call	qsort

	push	QWORD 0	; new list
	lea		r8, [rsp + 8]
	mov		rcx, r13
.loop2:
	test	rcx, 0
	je		.L1
	mov		rdi, r8
	lea		r9, [r14 + rcx * 8]
	mov		rsi, [r9]
	call	ft_list_push_front
	dec		rcx
	jmp		.loop2
.L1:
	


.end:
	pop		r14
	pop		r13
	pop		r12
	pop		rbx

	leave
	ret

