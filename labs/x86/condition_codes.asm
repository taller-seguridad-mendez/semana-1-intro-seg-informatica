section .text
	global _start

_start:
	; clear registers first
	xor eax, eax
	xor ebx, ebx

	; set zero flag (ZF)
	mov eax, 5
zf:
	sub eax, 5

	; set sign flag (SF)
	mov eax, 3
sf:
	sub eax, 5

	; set carry flag (CF)
	mov eax, 0
cf:
	sub eax, 1

	; set overflow flag (OF)
	mov eax, 0x7FFFFFFF
of:
	add eax, 1

exit:
	mov eax, 1
	xor ebx, ebx
	int 0x80
