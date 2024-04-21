;--------------------------------------------------
; 		ASSIGNMENT 2
;	SUJIT SHAHA  		SYCOD255
;--------------------------------------------------

section .data
    
    
    pmsg db 10,"COUNT OF POSITIVE NUMBERS : "
    pmsg_len equ $-pmsg
    nmsg db 10,"Number of Negative Nubers : "
    nmsg_len equ $-nmsg
    arr64 dd  -11H,-22H,-33H,-44H,55H,-66H,-77H,88H,-99H,-111H
    n equ 10
    nline db 10
    nline_len equ $-nline
    

;--------------------------------------------------
section .bss
    
    n_count resd 1
    p_count resd 1
    char_ans resb 2
    

;--------------------------------------------------

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


;--------------------------------------------------

section .text
global _start
_start:
	mov rsi,arr64
	mov rbx,0
	mov rdx,0
	mov rcx,n
	
   next_num:
   	mov rax,[rsi]
   	shl rax,1
   	jc negative
   	
   positive:
   	inc rbx
   	jmp next
   	
   negative:
   	inc rdx
   	
   next:
   	add rsi,4
   	dec rcx
   	jnz next_num
   	
   	mov [p_count],rbx
   	mov [n_count],rdx
   	Print pmsg,pmsg_len
   	mov rax,[p_count]
   	call display
   	
   	Print nmsg,nmsg_len
   	mov rax,[n_count]
   	call display
   	Print nline,nline_len
   	
   	Exit
   	

;--------------------------------------------------

display:
    mov rbx,16
    mov rcx,2
    mov rsi,char_ans + 1
    
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
    
  
    Print char_ans,2
     ret
     
     
;--------------------------------------------------
