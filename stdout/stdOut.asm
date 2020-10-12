global _start

section .data
msg 	db "Hello, world", 10
msg_len	equ $-msg

section .text
_start: mov eax, 4		; syscall 'write' has code 4
	mov ebx, 1		; std out has index 1 in linux
	mov ecx, msg		; syscall 'write' will check eax, ebx, ecx, edx
	mov edx, msg_len	
	int 80h			; make system call

; finish the process
	mov eax, 1		; syscall '_exit' has code 1
	mov ebx, 0		; 0 is the code of successfully finished process
	int 80h
