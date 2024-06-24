.text

pascal_value: # input %r6=r %r7=n  output: %r3
	stmg	%r6, %r15, 6*8(%r15)
	aghi	%r15, -160
    # --------------------------
    la %r13,0
    cr %r6,%r13
    je pascal_value_end_before
    cr %r7,%r6
    je pascal_value_end_before

    afi %r7,-1
    brasl 14,pascal_value
    lr %r11,%r3
    afi %r6,-1
    brasl 14,pascal_value
    ar %r11,%r3
    lr %r3,%r11
    j pascal_value_end
    
pascal_value_end_before:
    la %r3,1

pascal_value_end:
    #---------------------------
    aghi	%r15, 160
	lmg	%r6, %r15, 6*8(%r15)
	br	%r14

.globl asm_main

asm_main:
	stmg	%r6, %r15, 6*8(%r15)
	aghi	%r15, -160
	
    # ---------------------------	
    brasl 14,read_int
    la %r8,1
    lr %r7,%r2
    la %r6,0

loop:
    cr %r6,%r7
    je out
    brasl 14,pascal_value   # input %r6=r %r7=n   output: %r3
    lr %r2,%r3
    brasl 14,print_int
    la %r2,32
    brasl 14,print_char
    la %r6,1(0,%r6)
    j loop
out:
    la %r2,1
    brasl 14,print_int
    brasl 14,print_nl
    # ---------------------------	

	aghi	%r15, 160
	lmg	%r6, %r15, 6*8(%r15)
	br	%r14

