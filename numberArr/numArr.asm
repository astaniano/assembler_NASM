%include "stud_io.inc"
global _start

section .bss
nums resb 5

section .text
_start: mov ecx, 5 
	mov edi, nums
	mov al, 49

addNum: mov [edi], al
	inc edi
	inc eax
        dec ecx
        jnz addNum
			
	mov ecx, 5	
	mov edi, nums

printN: mov al, [edi]
	PUTCHAR al
	inc edi
	dec ecx
	jnz printN	

	PUTCHAR 10
        FINISH
