%include "asm_io.inc"

segment .data
    fp_print_format: db "%.3lf", 0

segment .bss
    sum: resq 1
    tann: resd 1
    wordtann: resw 1
    dwordtann: resd 1
    qwordtann: resq 1
    tann2: resq 1

    up: resq 1
    down: resq 1


segment .text

global asm_main
extern printf

asm_main:
	push rbp
    push rbx
    push r12
    push r13
    push r14
    push r15

    sub rsp, 8

    ; -------------------------

    
    ; a + bi
    ; c + di
    ;r15->a  r14->b  r13->c  r12->d
    call read_int 
    mov r15,rax

    call read_char ;space

    mov rbp,1
    call read_char ;sign
    cmp rax,45
    jne pos
    mov rbp,-1

pos:
    call read_char

    call read_int
    xor rdx,rdx
    mul rbp
    mov r14,rax

    call read_char


    call read_int
    mov r13,rax

    call read_char

    mov rbp,1
    call read_char ;sign
    cmp rax,45
    jne posi
    mov rbp,-1
posi:
    call read_char

    call read_int
    xor rdx,rdx
    mul rbp
    mov r12,rax

    call read_char

    ;mov rdi,r15
    ;call print_int
    ;call print_nl

    ;mov rdi,r14
    ;call print_int
    ;call print_nl

    ;mov rdi,r13
    ;call print_int
    ;call print_nl

    ;mov rdi,r12
    ;call print_int
    ;call print_nl
    ;call print_nl
    ; a + bi
    ; c + di
    ;r15->a  r14->b  r13->c  r12->d

    xor dx,dx
    mov rax,r13
    mul r13
    mov rbx,rax
    xor rdx,rdx
    mov rax,r12
    mul r12
    add rbx,rax   ;rbx== c^2 + d^2

    mov rdi,r15

    xor rdx,rdx
    mov rax,rdi
    mul r13
    mov r15,rax
    xor rdx,rdx
    mov rax,r14
    mul r12
    add r15,rax   ;r15== a*c + b*d
    
    xor rdx,rdx
    mov rax,r14
    mul r13
    mov rbp,rax
    xor rdx,rdx
    mov rax,rdi
    mul r12
    sub rbp,rax   ; rbp== b*c - a*d

    


    ; final result is (ac + bd)/(c^2 + d^2) + (bc - ad)/(c^2 + d^2) i  ===  r15/rbx + (rbp/rbx) i     

    ;mov rdi,rbx
    ;call print_int
    ;call print_nl

    ;mov rdi,r15
    ;call print_int
    ;call print_nl

    ;mov rdi,rbp
    ;call print_int
    ;call print_nl
    ;call print_nl

    xor rdx,rdx
    mov rax,r15
    mul r15
    mov r12,rax  ; r15^2 in r12

    xor rdx,rdx 
    mov rax,rbp
    mul rbp
    mov r13,rax  ; rbp ^2 in r13

    add r12,r13  ; r15^2 + rbp^2 in r12

    xor rdx,rdx
    mov rax,rbx
    mul rbx
    mov r13,rax  ; rbx^2 in r13

    ;mov rdi,rbp
    ;call print_int
    ;call print_nl
    ;mov rdi,r15
    ;;call print_int
    ;call print_nl
    ;call print_nl

    ;
    ;
    ;
    ;calc R and store in sum
    cvtsi2sd xmm0, r12
    cvtsi2sd xmm1, r13
    divsd xmm0, xmm1
    sqrtsd xmm0,xmm0
    movsd [sum],xmm0


    ;cvtsi2sd xmm0, rbp
    ;cvtsi2sd xmm1, r15
    ;divsd xmm0, xmm1
    ;mov rdi,-1
    ;cvtsi2sd xmm1, rdi
    ;mulsd xmm0,xmm1
    ;cvtsd2ss xmm0,xmm0 
    ;movss [dwordtann],xmm0

    mov [up] , rbp
    mov [down] , r15
    fild dword[up]
    fild dword[down]
    fpatan
    fstp qword[qwordtann]

    movsd xmm0,[qwordtann]
    mov rdi,-1
    cvtsi2sd xmm1, rdi
    mulsd xmm0,xmm1
    movsd [qwordtann],xmm0




    ;fld dword[dwordtann]
    ;fpatan
    ;fstp qword [qwordtann] 
    ;
    ;
    ;

    ;calculating imotional and real part
    ;cvtsi2sd xmm0, r15
    ;cvtsi2sd xmm1, rbx
    ;divsd xmm0, xmm1
    ;movsd [real],xmm0

    ;cvtsi2sd xmm0, rbp
    ;cvtsi2sd xmm1, rbx
    ;divsd xmm0, xmm1
    ;mov rdi,-1
    ;cvtsi2sd xmm1,rdi
    ;mulsd xmm0,xmm1
    ;movsd [imo],xmm0  
    ;


    ;calculating R 
    ;movsd xmm0,[real]
    ;movsd xmm1,[real]
    ;mulsd xmm0,xmm1
    ;movsd [real2],xmm0

    ;movsd xmm0,[imo]
    ;movsd xmm1,[imo]
    ;mulsd xmm0,xmm1
    ;movsd [imo2],xmm0

    ;movsd xmm0,[real2]
    ;movsd xmm1,[imo2]
    ;addsd xmm0,xmm1
    ;sqrtsd xmm0,xmm0
    ;movsd [sum],xmm0
    ;
    ;calculating Tetha
    ;movsd xmm0,[imo]
    ;movsd xmm1,[real]
    ;divsd xmm0,xmm1
    ;movsd [tann],xmm0

    ;fild dword [tann]
    ;fpatan
    ;fstp dword [tann]

    ;movsd xmm0,[qwordtann]
    ;mov rdi, fp_print_format
    ;mov rax, 1
    ;call printf
    ;call print_nl


    movsd xmm0,[sum]
    mov rdi, fp_print_format
    mov rax, 1
    call printf

    mov rdi,32
    call print_char
    mov rdi,120
    call print_char
    mov rdi,32
    call print_char
    mov rdi,101
    call print_char

    movsd xmm0,[qwordtann]
    mov rdi, fp_print_format
    mov rax, 1
    call printf

    mov rdi,105
    call print_char      
    call print_nl


    ;

    ;--------------------------

    add rsp, 8

	pop r15
	pop r14
	pop r13
	pop r12
    pop rbx
    pop rbp

	ret
