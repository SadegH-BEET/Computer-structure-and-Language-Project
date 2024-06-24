.text
.globl asm_main
    asm_main:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)
	
    # ---------------------------	
    brasl 14,read_int
    lr %r6,%r2
loop: 
    brasl 14,read_char
    lr %r8,%r2
    la %r7,38
    cr %r8,%r7
    je and
    la %r7,124
    cr %r8,%r7
    je or
    la %r7,94
    cr %r8,%r7
    je xor
    la %r7,126
    cr %r8,%r7
    je not
    j out
and:
    brasl 14,read_int
    lr %r9,%r2
    nr %r6,%r9
    j loop
or:
    brasl 14,read_int
    lr %r9,%r2
    or %r6,%r9
    j loop
xor:
    brasl 14,read_int
    lr %r9,%r2
    xr %r6,%r9
    j loop
not:
    # xr %r9,%r9
    la %r9,1
    # sr %r9,%r3
    lcr %r9,%r9
    xr %r6,%r9
    j loop
out:  
    lr %r2,%r6
    brasl 14,print_int
    # ---------------------------	

    lay     %r15, 200(%r15)
    lmg     %r11, %r15, -40(%r15)
    br      %r14
