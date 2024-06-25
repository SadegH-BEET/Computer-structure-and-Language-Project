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
    call read_int 
    mov r15, rax
    ;using r15 to store value of n
    mov r14,1
    ;using r14 as index
    mov rdi,0
    call print_int
    call print_nl 

loop:
    cmp r14,r15
    jae loop_end
    ;check palindrom in 10 base
    mov r13,r14
    ;using r13 for temp r14
    mov r12,0 
    ;using r12 to store mirrored value 
loop1:  ;mirroring 10 base
    cmp r13,0
    je loop2
    ;
    xor rdx,rdx
    mov rax,r13
    mov r10,10
    div r10
    mov r13,rax ;// by 10
    mov r9,rdx ;reminder by 10
    mov rax,r12
    mul r10
    mov r12,rax
    add r12,r9
    jmp loop1
    ;
loop2:
    ;subtracking for checking 10 base mirror
    cmp r14,r12
    jne loop_continue

    ;using r13 for temp r14
    mov r13,r14
    ;using r12 to store mirrored value 
    mov r12,0
loop3:  ;mirroring 2 base
    cmp r13,0
    je loop4
    ;
    shr r13,1
    mov rax,0
    adc rax,0
    shl r12,1
    add r12,rax
    jmp loop3
    ;
loop4:
    cmp r14,r12
    jne loop_continue
    mov rdi,r14     ;printing value
    call print_int
    call print_nl
loop_continue:
    inc r14
    jmp loop

loop_end:

    ;--------------------------

    add rsp, 8

	pop r15
	pop r14
	pop r13
	pop r12
    pop rbx
    pop rbp

	ret
