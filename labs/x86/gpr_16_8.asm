section .text
	global _start

_start:
	mov eax, 0xFFFF0000
	mov  ax, 0xFFFF
	mov ebx, 0xFFFF0000
	mov  bh, 0xFF
	mov  bl, 0xFF

exit:
	mov eax, 1
	xor ebx, ebx
	int 0x80
