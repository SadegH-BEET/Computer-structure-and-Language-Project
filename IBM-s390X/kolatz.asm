
.text
.globl asm_main
    asm_main:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)
	
    # ---------------------------	

    brasl 14,read_int
    lr %r9,%r2
    la %r13,0
    la %r12,1     
    la %r10,2       
    la %r7,3 
loop:
    lr %r2,%r9
    brasl 14,print_int
    la %r2,32
    brasl 14,print_char
    cr %r9,%r12
    je out
    lr %r6,%r9
    nr %r6,%r12
    cr %r6,%r12
    jz odd
    jnz even
odd:
    xr %r8,%r8
    mr %r8,%r7
    ar %r9,%r12
    j loop
even:
    xr %r8,%r8
    dr %r8,%r10
    j loop
out:
    brasl 14,print_nl
    # ---------------------------	
    lay     %r15, 200(%r15)
    lmg     %r11, %r15, -40(%r15)
    br      %r14
