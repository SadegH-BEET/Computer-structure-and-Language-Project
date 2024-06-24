.text
.globl asm_main
    asm_main:
    stmg     %r11, %r15, -40(%r15)
    lay      %r15, -200(%r15)
	
    # ---------------------------	
    
	brasl 14,read_int	# r7
	lr %r7,%r2
	la %r6,2
	xr %r10,%r10
	cr %r7,%r10
	je out
	# ------- (2^n)-1
loop1:
    xr %r8,%r8
    mr %r8,%r6
    la %r10,1(0,%r10) 
    cr %r10,%r7
    jne loop1
    afi %r9,-1			# r9
    # --------
loop2:
	xr %r2,%r2
	cr %r9,%r2
	je out
	lr %r10,%r9
	la %r8,1
	la %r12,0
	la %r13,0
	srdl %r10,0(%r7)
	la %r2,123
    brasl 14,print_char
loop3:
	cr %r8,%r7
	jh loop5
	sldl %r10,1
	la %r2,1
	nr %r10,%r2
	cr %r10,%r2
	je loop4  # 1 founded!!!
	afi %r8,1
	j loop3 # 0 founded
loop4:
	la %r2,0
	cr %r2,%r13
	je first_one
	la %r2,44
	brasl 14,print_char
	lr %r2,%r8
	brasl 14,print_int
	afi %r8,1
	afi %r13,1
	j loop3
first_one:
	lr %r2,%r8
	brasl 14,print_int
	afi %r8,1
	afi %r13,1
	j loop3
loop5:
	afi %r9,-1
	la %r2,125
    brasl 14,print_char
    brasl 14,print_nl
	j loop2
out:
    la %r2,123
    brasl 14,print_char
    la %r2,125
    brasl 14,print_char
    brasl 14,print_nl
    # ---------------------------	

    lay     %r15, 200(%r15)
    lmg     %r11, %r15, -40(%r15)
    br      %r14
