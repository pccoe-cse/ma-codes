section .data

msg db "Hello"
msg_len = equ $-msg
stet1 db "Enter the input"
stet1_len = equ $-stet1



section .bss

buffer resb 20
buffer_len equ $-buffer

%macro Read 2
mov rax,0
mov rdi,0
mov rsi,%1
mov rdx,%2
syscall
%endmacro

%macro Print 2
mov rax,1
mov rdi,1
mov rsi,%1
mov rdx,%2
syscall
%endmacro

%macro Exit 0
mov rax,60
mov rdi,0
syscall
%endmacro

section .text

global _start
_start:

Print msg,msg_len
Print stet1,stet1_len
Read buffer,buffer_len
Print buffer,buffer_len
Exit

