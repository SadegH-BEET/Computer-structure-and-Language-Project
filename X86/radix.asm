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
    ;using r15 as n
    mov r15,rax
    mov r14,0 
    ;using r14 as index
loop:
    ;loop to iterate n time
    add r14,1
    cmp r14,r15
    ja loop_end
    call read_int
    ;using r13 as p
    mov r13,rax
    call read_int 
    ;using r12 as q
    mov r12,rax
    call read_int 
    ;using rbp as r
    mov rbp,rax
    ;using r8 as radix.z
    mov r8,1
    ;using r9 as temp
    mov r9,0

loop1:
    ;converting base p to base 10
    cmp rbp,0
    je loop22
    xor rdx,rdx
    mov rax,rbp
    mov rsi,10
    div rsi
    mov rbp,rax
    mov rax,rdx
    xor rdx,rdx
    mul r8
    add r9,rax
    xor rdx,rdx
    mov rax,r8
    mul r13
    mov r8,rax
    jmp loop1

    ;base 10 number in r9
    ;n in r15
    ;index r14
    ;p in r13
    ;q in r12
    ;base q number in rbp
loop22:
    mov rsi,1
loop2:
    ;converting base 10 to base q
    ; // r9 
    cmp r9,0
    je loop3
    mov rax,r9
    xor rdx,rdx
    div r12
    mov r9,rax
    mov rax,rdx
    xor rdx,rdx
    mul rsi
    add rbp,rax
    xor rdx,rdx
    mov rcx,10
    mov rax,rsi
    mul rcx
    mov rsi,rax
    jmp loop2
    ; end of converting 10 base to q base
loop3:
    mov rdi,rbp
    call print_int
    call print_nl
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
