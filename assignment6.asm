;--------------------------------------------------
; 		   ASSIGNMENT 6
;	SUJIT SHAHA  		SYCOD255
;--------------------------------------------------

section .data
    
    sblock db 10h,20h,30h,40h,50h
    dblock db 0h,0h,0h,0h,0h
    msg db 10,"S block before tranfer : "
    msg_len equ $-msg
    msg2 db 10,"D block before transfer :  "
    msg2_len equ $-msg2 
    amsg db 10,"S block after tranfer : "
    amsg_len equ $-amsg
    amsg2 db 10,"D block after transfer :  "
    amsg2_len equ $-amsg2 
    space db " "
    

;--------------------------------------------------
section .bss
    
    buf resb 5
    ans resb 16
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
	
	Print msg,msg_len
	mov rsi,sblock
	call displayBlock
	Print msg2,msg2_len
	mov rsi,dblock
	call displayBlock
call block_transfer
Print amsg,amsg_len
	mov rsi,sblock
	call displayBlock
Print amsg2,amsg2_len
	mov rsi,dblock
	call displayBlock
 	
   	Exit
   	

;--------------------------------------------------

block_transfer : 
	mov rsi,sblock
	mov rdi,dblock
	mov rcx,5
	
	
  nextBlock:
	mov al,[rsi]
	mov[rdi],al
	
	inc rsi
	inc rdi
	dec rcx
	jnz nextBlock
	ret
	

;--------------------------------------------------

displayBlock :
mov rbp,5

next : 
mov al,[rsi]
push rsi
call display
Print space,1
pop rsi
inc rsi
dec rbp
jnz next

ret


display:
    mov rbx,16
    mov rcx,5
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
