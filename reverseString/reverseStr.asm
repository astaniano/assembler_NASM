%include "stud_io.inc" 
global _start 
 
section .data
welmsg 	db 'Welcome bro=)).'

section .text
_start: xor ebx, ebx
	xor ecx, ecx
	mov esi, welmsg

lp:	mov bl, [esi+ecx]
	cmp bl, 46
	je lpquit
	push ebx
	inc ecx
	jmp lp
	
lpquit:	jecxz done
	mov edi, esi	

lp2:	pop ebx
	mov [edi], bl
	inc edi
	loop lp2

printStr:
	mov bl, [esi+ecx]
	cmp bl, 46
	je done
	PUTCHAR bl
	inc ecx
	jmp printStr

done:	PUTCHAR 10
	FINISH




