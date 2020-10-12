global _start

section .data
pattern dd 'a?c.'                ; 4 bytes each ch in string
string  dd 'abc.'                ; 4 bytes each ch in string

section .text
_start: xor ebp, ebp            ; zero ebx
	xor esp, esp 
	xor ebx, ebx 
	xor esi, esi 
	xor edi, edi 
               
		                ; call function match
        push dword pattern
        push dword string
	call match
	add esp, 8

match:	
	push ebp
	mov ebp, esp
	sub esp, 4

	push esi
	push edi
	mov esi, [ebp+8]
	mov edi, [ebp+12]

again:	cmp byte [edi], 46
	jne .not_end

.not_end:
	cmp byte [edi], '*'
	

done:   PUTCHAR 10              ; end of line
        FINISH

