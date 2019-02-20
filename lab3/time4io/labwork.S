  # labwork.S
  # Written 2015-2017 by F Lundevall
  # Skeleton file for IS1200/IS1500 lab 1.
  # The macros PUSH and POP are in the public domain.
  # Please add your own code at the end of the file.

  #
  # Please keep the two macros PUSH and POP unchanged
  #
.macro	PUSH reg
	addi	$sp,$sp,-4
	sw	\reg,0($sp)
.endm

.macro	POP reg
	lw	\reg,0($sp)
	addi	$sp,$sp,4
.endm
  #
  # Please add your own code below this line
  #
  	
  	.text
  	.global time2string
time2string:

	PUSH	$s0
	PUSH	$s1
	PUSH	$ra
	move	$s0,$a0
	move	$s1,$a1
	
	srl	$a0,$s1,12
	jal	hexasc
	nop
	sb	$v0,0($s0)
	
	srl	$a0,$s1,8
	jal	hexasc
	nop
	sb	$v0,1($s0)
	
	li	$t0,0x3A
	sb	$t0,2($s0)
	
	srl	$a0,$s1,4
	jal	hexasc
	nop
	sb	$v0,3($s0)
	
	srl	$a0,$s1,0
	andi	$t0,$a1,0xf
	beq 	$t0,2,two #när $a0 är 2, gör two
	nop
	jal	hexasc
	nop
	sb	$v0,4($s0)
	
	sb	$0,5($s0)
	
	POP	$ra
	POP	$s1
	POP	$s0
	
	jr	$ra
	nop
	
	two:	
	
	li	$t0,0x54 #T
	sb	$t0,4($s0)
	li	$t1,0x57 #W
	sb	$t1,5($s0)
	li	$t2,0x4f #O
	sb	$t2,6($s0)
	sb	$0,7($s0) #0
	POP	$ra
	POP 	$s1
	POP	$s0
	jr 	$ra
	nop
	
  # you can write your code for subroutine "hexasc" below this line
  #
hexasc:	
	andi	$t0,$a0,0xf	#masking to keep only the 4 least significant bits
	li	$t1, 9		#assigns the value 9 to $t1
	ble	$t0, $t1, liten	#compares $t0 to $t1, branches if true
	nop
	
	addi	$v0,$t0,0x37	#adds 0x37 to $t0, sets as the return value
	jr	$ra		#returns to main subroutine
	nop
	
	liten:
	addi	$v0,$t0,0x30	#adds 0x30 to $t0, sets as the return value
	jr	$ra		#returns to main subroutine
	nop
	.global delay
	delay:
		li	$t3,6000000
		li 	$t0,0
	 while:
		
		
		blez 	$a0, delayend
		nop
		sub	$a0,$a0,1
	 for:
		addi	$t0,$t0,1
		nop
		ble	$t0,$t3,for
		nop
		bge	$t0,$t3,while
		nop
	delayend:
		jr $ra
		nop	