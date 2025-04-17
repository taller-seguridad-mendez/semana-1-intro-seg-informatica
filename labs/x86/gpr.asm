section .text
	global _start

_start:
	mov eax, 0x12345678
	mov ebx, 0xFFFFFFFF

exit:
	mov eax, 1
	xor ebx, ebx
	int 0x80
