;--------------------------------------------------
; 		   ASSIGNMENT 4
;	SUJIT SHAHA  		SYCOD255
;--------------------------------------------------

section .data
    
    
    msg db "Enter the valid HEX number : "
    msg_len equ $-msg
    msg2 db "The BCD form of the Entered HEX Number is : "
    msg2_len equ $-msg2 
    err db "ENTERED THE INVALID HEX NUMBER"
    err_len equ $-err;
    nline db 10
    nline_len equ $-nline
    

;--------------------------------------------------
section .bss
    
    buf resb 5
    ans resb 16
    char_ans resb 5
    

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
	
	call HEX_BCD  	
   	Exit
   	

;--------------------------------------------------

HEX_BCD : 
	Print msg,msg_len
	Read buf,5
	mov rsi,buf
	xor bx,bx
	mov rcx,4
	
  next:
	shl bx,4
	mov al,[rsi]
	
	cmp al,'0'
	jb error
	cmp al,'9'
	jbe sub30h
	
	cmp al,'A'
	jb error
	cmp al,'F'
	jbe sub37h
	
	cmp al,'a'
	jb error
	cmp al,'f'
	jbe sub57h
	
	jmp error
	
  sub57h: sub al,20h
  sub37h: sub al,07h
  sub30h: sub al,30h
  
  	add bx,ax
  	
  	inc rsi
  	dec rcx
  	jnz next
  	
  	 
	
	mov [ans],bx
	Print msg2,msg2_len
	
	mov ax,[ans]
	call display10
	ret
	
error: Print err,err_len
	Print nline,nline_len
	call HEX_BCD
	Exit
	
;--------------------------------------------------

display10:
    mov rbx,10
    mov rcx,5
    mov rsi,char_ans + 4
    
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
    
  
    Print char_ans,5
     ret
     
     
;--------------------------------------------------
