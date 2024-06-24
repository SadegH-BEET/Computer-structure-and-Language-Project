.text
.globl asm_main
hanoi:        # input %r9:N , %r6:0 , %r7:2 , %r8:1   Hanoi(N, from_rod , to_rod , aux_rod)
	stmg	%r6, %r15, 6*8(%r15)
	aghi	%r15, -160
	#--------------------
    # Base-case
	la	11,0
	cr	9,11
	je	hanoi_end	

    la %r1,1
    # Hanoi(N-1, from_rod , aux_rod , to_rod)
    sr %r9,%r1
	lr %r13,%r7
	lr %r7,%r8
	lr %r8,%r13
	brasl 14,hanoi
    #-------------------

	la %r2,40
	brasl 14,print_char
	lr %r2,%r6
	brasl 14,print_int
	la %r2,44
	brasl 14,print_char
	lr %r2,%r8
	brasl 14,print_int
	la %r2,41
	brasl 14,print_char
	brasl 14,print_nl

	#-------------------
    # Hanoi(N-1, aux_rod , to_rod , from_rod)
	lr %r13,%r6
    lr %r6,%r7
    lr %r7,%r13
    lr %r13,%r7
    lr %r7,%r8
    lr %r8,%r13
	brasl 14,hanoi
hanoi_end:
	#--------------------
	aghi	%r15, 160
	lmg	%r6, %r15, 6*8(%r15)
	br	%r14


asm_main:
	stmg	%r6, %r15, 6*8(%r15)
	aghi	%r15, -160

    #-----------------
	brasl 14,read_int
	lr %r9,%r2
	la %r6,0
	la %r7,2
	la %r8,1
    # input %r9:N , %r6:0 , %r7:2 , %r8:1   Hanoi(N, from_rod , to_rod , aux_rod)
	brasl 14,hanoi
    #-----------------

	aghi	%r15, 160
	lmg	%r6, %r15, 6*8(%r15)
	br	%r14
