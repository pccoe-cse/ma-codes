;--------------------------------------------------
; 		   ASSIGNMENT 3
;	SUJIT SHAHA  		SYCOD255
;--------------------------------------------------

section .data
    
    
    msg db "Enter the valid BCD number : "
    msg_len equ $-msg
    msg2 db "The Hexadecimal form of the Entered BCD Number is : "
    msg2_len equ $-msg2 
    

;--------------------------------------------------
section .bss
    
    buf resb 6
    ans resb 16
    char_ans resb 6
    

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
	
	call BCD_HEX   	
   	Exit
   	

;--------------------------------------------------

BCD_HEX : 
	Print msg,msg_len
	Read buf,6
	mov rsi,buf
	xor eax,eax
	mov rbp,5
	mov ebx,10
	
  next:
	xor cx,cx
	mul ebx
	mov cl,[rsi]
	sub cl,30h
	add eax,ecx
	
	inc rsi
	dec rbp
	jnz next
	
	mov [ans],eax
	Print msg2,msg2_len
	
	mov eax,[ans]
	call display
	ret
	
;--------------------------------------------------

display:
    mov rbx,16
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
