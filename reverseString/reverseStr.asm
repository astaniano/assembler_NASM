%include "stud_io.inc" 
global _start 
 
section .data
welmsg 	db 'Welcome bro=)).' 	; 1 byte each ch in string

section .text
_start: xor ebx, ebx		; zero ebx
	xor ecx, ecx		; zero ecx
	mov esi, welmsg		; addrress of the string beginning -> esi


				; dot determines end of the string
lp:	mov bl, [esi+ecx]	; string ch to
	cmp bl, 46		; 46 is ascii for dot
	je lpquit		; if dot in ebx => loop is over
	push ebx		; push string ch to stack
	inc ecx			; ecx++
	jmp lp			; again to lp
	
lpquit:	jecxz done		; basically for future if there empty input strings jump to done
	mov edi, esi		

lp2:	pop ebx			; get from the top of stack
	mov [edi], bl		; rewrite old symbol with the one from the top of the stack
	inc edi			; edi++
	loop lp2		; decrement ecx. if ecx != 0 jump to lp2

printStr:			; print reversed string
	mov bl, [esi+ecx]	
	cmp bl, 46		; string ends with dot
	je done			; if ch == '.' jump to done
	PUTCHAR bl		; ch to stdout
	inc ecx			; ecx++
	jmp printStr		; again printStr

done:	PUTCHAR 10		; end of line
	FINISH




