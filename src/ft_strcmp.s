global ft_strcmp

; rdi = const char *s1
; rsi = const char *s2
ft_strcmp:
	xor			eax, eax
	xor			rcx, rcx
	xor			rdx, rdx
.loop:
	add			rdx, rcx
	movdqu		xmm0, oword [rdi + rdx]
	pcmpistri	xmm0, oword [rsi + rdx], 0b00011000
	ja			.loop								; CFlag(IntRes2) = 0 && ZFlag = 0
	jnc			.end

	// TODO: check
	add			rdx, rcx
	movzx		eax, BYTE [rdi + rdx]
	movzx		ecx, BYTE [rsi + rdx]
	sub			eax, ecx
.end:
	ret

