global ft_list_sort

extern ft_list_push_front
extern ft_list_size
extern malloc
extern qsort

section .text

; void ft_list_sort(t_list **lst, int (*cmp)())
ft_list_sort:
	enter	0, 0

	push	rbx				; **lst
	push	r12				; (*cmp)
	push	r13				; listsize
	push	r14				; t_list *array[]

	; get listsize, exit early if zero or one
	mov		rdi, [rbx]
	call	ft_list_size
	cmp		rax, 2
	jge		.end
	mov		r13, rax

	; malloc an array
	mov		rdi, rax
	imul	rdi, 8
	call	malloc
	test	rax, rax
	jz		.end
	mov		r14, rax
	
	; fill array
	xor		rcx, rcx
	mov		r8, [rbx]		; t_list *current
.fill:
	cmp		rcx, r13
	je		.sort
	lea		r9, [r14 + rcx * 8]
	mov		r9, r8
	mov		r8, [r8]
	inc		rcx
	jmp		.fill

	; sort array
.sort:
	mov		rdi, r14
	mov		rsi, r13
	mov		rdx, 8
	mov		rcx, cmp_wrap

.end:
	pop		r14
	pop		r13
	pop		r12
	pop		rbx

	leave
	ret

; int cmp(t_list *f, t_list *g, int (*cmp)()) { return cmp(f->data, g->data); }
cmp_wrap:
	enter	0, 0
	
	lea		rdi, [rdi + 8]
	lea		rsi, [rsi + 8]
	call	rdx

	leave
	ret
