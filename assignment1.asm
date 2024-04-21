section .data
    msg db "Enter your String : ",10
    msg_len equ $-msg
     msg1 db "length of your String : "
    msg1_len equ $-msg1
section .bss
    
    buffer resb 200
    buffer_len equ $-buffer
    char_ans resb 4
    

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
    Read buffer,buffer_len        
    dec rax	
    call display
    
    Exit

display:
    mov rbx,16
    mov rcx,4
    mov rsi,char_ans + 3
    
cnt:
    mov rdx,0
    div rbx
    
    cmp dl,09h
    jbe add30
    add dl,07h
    
    
    
add30:
    add dl,30h
    mov [rsi],dl
    dec rsi
   
    dec rcx
    jnz cnt
    
    Print msg1,msg1_len
    Print char_ans,16
     ret
