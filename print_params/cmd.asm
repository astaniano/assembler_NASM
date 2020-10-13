global 	_start

section .text

nlstr	db 10, 0 		; string contains feed line (10 in ascii) and 0 as end of the string

strlen:
	push ebp		; save old ebp (stack reference point of print_str func)
	mov ebp, esp		; ebp is now a reference point in the stack
	xor eax, eax		; zero eax
	mov ecx, [ebp+8]	; address of first param to ecx
.lp	cmp byte [eax+ecx], 0	; if end of string. (string ends with 0)
	jz .quit		; if res == 0 go to .quit
	inc eax			; eax++. we need to point to the next letter of the string param in the next iteration
	jmp short .lp
.quit	pop ebp			; restore old ebp (stack reference point of print_str func)
	ret			; after return eax will contain string (param) length

print_str:
	push ebp		; save ebp (what there was before func call)
	mov ebp, esp		; ebp is now reference point in the stack
	push ebx		; push args count to the stack. ebx will be spoiled
	mov ebx, [ebp+8]	; put first param before the function call to the ebx (in our case "./cmd")
	push ebx		; push function param to the stack
	call strlen		
	add esp, 4		; "forget" about the param
	
	; syscall 'write' will check eax, ebx, ecx, edx
	mov edx, eax		; copy str length to edx
	mov ecx, ebx		; args[i] was in ebx. ecx is needed for "syscall_write". it should contain str address
	mov ebx, 1		; stdout stream has index '1' in linux. ebx contains ind of output stream
	mov eax, 4		; syscall 'write' has code 4
	int 0x80		; make syscall

	; finish function
	pop ebx			; restore ebx (args count)
	pop ebp			; restore ebp (whatever it was before func call)
	ret

; entry point of the programm
_start:
	mov ebx, [esp]		; ebx now has args count that is put at the top of the stack by OS
	mov esi, esp		; esi now points to the args count
	add esi, 4		; esi now points to the first arg ("./cmd" in our case)

again:	push dword [esi]	; push args[i] to the stack; args[i] will be used as a param in print_str
	call print_str		; will print args[i] val
	add esp, 4		; forget about the param
	push dword nlstr	; param for the next func call
	call print_str		; prints feed line symbol
	add esp, 4		; forget about the param
	add esi, 4		; esi contains the address of next args 
	dec ebx			; argsCount--
	jnz again		; if count not 0 jump to "again"

; finish the process
	mov eax, 1		; syscall '_exit' has code 1
	mov ebx, 0		; exit code 0 is the code of successfully finished process
	int 0x80		; make syscall
