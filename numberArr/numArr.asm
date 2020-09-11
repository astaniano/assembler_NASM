%include "stud_io.inc"
global _start

section .bss
nums resb 5			; arr of 1 byte nums

section .text
_start: mov ebx, 5		; amount of numbers to print
	mov al, 52		; ascii code for first num in arr
			
addNum: mov [nums+ecx], al	; put number inside nums arr
	inc eax			; get ascii of next number
        inc ecx			; inc ecx
	cmp ecx, ebx		; compare current iteration with total amount of nums
        jl addNum		; if less than total start from "addNum" again
			
	mov esi, nums		; move address of nums to esi
printN: mov al, [esi]		; move num from arr to al
	PUTCHAR al		; print current number
	PUTCHAR 32		; print space
	inc esi			; put address of the next RAM cell into edi
	loop printN		; dec ecx and if zero jump to "printN"
			
	PUTCHAR 10		; print end of line symbol
        FINISH			; sys call for exit
