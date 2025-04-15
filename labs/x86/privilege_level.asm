section .text
	global _start

_start:
	pushf

	pop eax
	and eax, 0xFFFFCFFF	; clear bits 12 & 13 -> IOPL = 0
	push eax

	popf

	out dx, al

exit:
	mov ebx, 1
	mov eax, 1
	int 0x80
