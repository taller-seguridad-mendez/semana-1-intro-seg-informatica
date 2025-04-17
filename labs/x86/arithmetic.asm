section .text
	global _start

_start:
	mov eax, 5
	add eax, 10
	sub eax, 3
	; your code here

	mov ebx, 0
	mov eax, 1
	int 0x80
