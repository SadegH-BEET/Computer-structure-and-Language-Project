%include "asm_io.inc"

segment .text

global asm_main

asm_main:
	push rbp
    push rbx
    push r12
    push r13
    push r14
    push r15

    sub rsp, 8

    ; -------------------------
    ; YYYY  MM   DD   HH   MM   SS
    ; rbx   rbp  r12  r13  r14  r15
    call read_int 
    mov rbx,rax    ;YYYY

    call read_int
    mov rbp,rax    ;MM

    call read_int
    mov r12,rax     ;DD

    call read_int
    mov r13,rax     ;HH

    call read_int
    mov r14,rax    ;MM

    call read_int  
    mov r15,rax    ;SS

    ;adding step
    call read_int
    add rbx,rax

    call read_int
    add rbp,rax

    call read_int
    add r12,rax

    call read_int
    add r13,rax

    call read_int
    add r14,rax

    call read_int
    add r15,rax

    ;transition

    ;xor rdx,rdx
    ;mov rax,r15
    ;mov r8,60
    ;div r8
    ;mov r15,rdx
    ;dd r14,rax

    cmp r15,60
    jb min
    mov rsi,60
    sub r15,rsi
    inc r14
min:
    ;xor rdx,rdx
    ;mov rax,r14
    ;mov r8,60
    ;div r8
    ;mov r14,rdx
    ;add r13,rax
    cmp r14,60
    jb hour
    mov rsi,60
    sub r14,rsi
    inc r13
hour:
    ;xor rdx,rdx
    ;xov rax,r13
    ;mov r8,24
    ;div r8
    ;mov r13,rdx
    ;add r12,rax
    cmp r13,24
    jb day
    mov rsi,24
    sub r13,rsi
    inc r12
day:
    ;xor rdx,rdx
    ;mov rax,r12
    ;mov r8,30
    ;div r8
    ;mov r12,rdx
    ;add rbp,rax
    cmp r12,31
    jb mounth
    mov rsi,30
    sub r12,rsi
    inc rbp
mounth:
    ;xor rdx,rdx
    ;mov rax,rbp
    ;mov r8,12
    ;div r8
    ;mov rbp,rdx
    ;add rbx,rax
    cmp rbp,13
    jb year
    mov rsi,12
    sub rbp,rsi
    inc rbx
year:
    
    ;printing step
    ;mov rdi,rbx
    ;call print_int
    ;call print_nl
         ;YYYY
    cmp rbx,999     
    ja end_print1
    mov rdi,0 
    call print_int
    cmp rbx,99
    mov rdi,0 
    ja end_print1
    call print_int
    cmp rbx,9
    mov rdi,0 
    ja end_print1
    call print_int
end_print1:
    mov rdi,rbx
    call print_int
    
    

    mov rdi,32      ;space
    call print_char

    mov rdi,0       ;MM
    cmp rbp,9
    ja end_print2
    call print_int
end_print2:
    mov rdi,rbp
    call print_int

    mov rdi,32      ;space
    call print_char

    mov rdi,0       ;DD
    cmp r12,9
    ja end_print3
    call print_int
end_print3:
    mov rdi,r12
    call print_int

    mov rdi,32      ;space
    call print_char

    mov rdi,0       ;HH
    cmp r13,9
    ja end_print4
    call print_int
end_print4:
    mov rdi,r13
    call print_int

    mov rdi,32      ;space
    call print_char

    mov rdi,0       ;MM
    cmp r14,9
    ja end_print5
    call print_int
end_print5:
    mov rdi,r14
    call print_int

    mov rdi,32      ;space
    call print_char

    mov rdi,0       ;SS
    cmp r15,9
    ja end_print6
    call print_int
end_print6:
    mov rdi,r15
    call print_int

    call print_nl
    ;--------------------------

    add rsp, 8

	pop r15
	pop r14
	pop r13
	pop r12
    pop rbx
    pop rbp

	ret