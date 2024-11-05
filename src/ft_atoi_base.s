global ft_atoi_base

extern isspace
extern strlen
extern strchr
extern strrchr

; rdi = const char *str
; rsi = const char *base
ft_atoi_base:
	enter	0, 0

	push	rbx				; str
	push	r12				; base
	push	r13				; sign
	push	r14				; basesize
	push	r15				; i

	mov		rbx, rdi
	mov		r12, rsi
	mov		r13d, 1
	mov		r15, 0

	mov		rdi, rsi
	call	strlen wrt ..plt
	mov		r14, rax		; save basesize
	
	; check base length
	cmp		r14, 2			; basesize < 2
	jl		.error

	; check if base contains '+ or -'
	mov		rdi, r12
	mov		esi, '+'
	call	strchr wrt ..plt
	cmp		rax, 0
	jne		.error
	mov		rdi, r12
	mov		esi, '-'
	call	strchr wrt ..plt
	cmp		rax, 0
	jne		.error

	; check if base contains duplicates or whitespace
.loop:
	cmp		BYTE [r12 + r15], 0
	jz		.whitespace
	mov		rdi, r12
	mov		esi, [r12 + r15]
	call	strchr wrt ..plt
	push	rax
	mov		rdi, r12
	mov		esi, [r12 + r15]
	call	strrchr wrt ..plt
	pop		rcx
	cmp		rax, rcx
	jne		.error
	movzx	edi, BYTE [r12 + r15]
	call	isspace wrt ..plt
	test	eax, eax
	jnz		.error
	inc		r15
	jmp		.loop

	; skip whitespace
.whitespace:
	movzx	rdi, BYTE [rbx]
	call	isspace wrt ..plt
	cmp		eax, 0
	je		.sign
	inc		rbx
	jmp		.whitespace

	; determine sign
.sign:
	mov		r15, 0			; total, for later
	cmp		BYTE [rbx], '+'
	je		.plus
	cmp		BYTE [rbx], '-'
	jne		.base
	neg		r13d
.plus:
	inc		rbx
	jmp		.sign
	
	; actually calculate the result
.base:
	mov		rdi, r12
	movzx	esi, BYTE [rbx]
	call	strchr wrt ..plt
	cmp		rax, 0
	je		.end
	sub		rax, r12
	cmp		rax, r14
	je		.end
	imul	r15d, r14d
	add		r15d, eax
	inc		rbx
	jmp		.base

.end:
	mov		eax, r15d
	imul	r13d		; implied eax

	pop		r15
	pop		r14
	pop		r13
	pop		r12
	pop		rbx

	leave
	ret

.error:
	mov		ecx, 0
	jmp		.end
