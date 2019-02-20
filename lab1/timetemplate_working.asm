  # timetemplate.asm
  # Written 2015 by F Lundevall
  # Copyright abandonded - this file is in the public domain.

.macro	PUSH (%reg)
	addi	$sp,$sp,-4
	sw	%reg,0($sp)
.end_macro

.macro	POP (%reg)
	lw	%reg,0($sp)
	addi	$sp,$sp,4
.end_macro

	.data
	.align 2
mytime:	.word 0x5957
timstr:	.ascii "text is text\0"
	.text
main:
	# print timstr
	la	$a0,timstr
	li	$v0,4
	syscall
	nop
	# wait a little
	li	$a0,2
	jal	delay
	nop
	# call tick
	la	$a0,mytime
	jal	tick
	nop
	# call your function time2string
	la	$a0,timstr #adress
	la	$t0,mytime
	lw	$a1,0($t0) #value
	jal	time2string
	nop
	# print a newline
	li	$a0,10
	li	$v0,11
	syscall
	nop
	# go back and do it all again
	j	main
	nop
# tick: update time pointed to by $a0
tick:	lw	$t0,0($a0)	# get time
	addiu	$t0,$t0,1	# increase
	andi	$t1,$t0,0xf	# check lowest digit
	sltiu	$t2,$t1,0xa	# if digit < a, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0x6	# adjust lowest digit
	
	andi	$t1,$t0,0xf0	# check next digit
	sltiu	$t2,$t1,0x60	# if digit < 6, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0xa0	# adjust digit
	
	andi	$t1,$t0,0xf00	# check minute digit
	sltiu	$t2,$t1,0xa00	# if digit < a, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0x600	# adjust digit
	
	andi	$t1,$t0,0xf000	# check last digit
	sltiu	$t2,$t1,0x6000	# if digit < 6, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0xa000	# adjust last digit
	
tiend:	sw	$t0,0($a0)	# save updated result
	jr	$ra		# return
	nop

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
delay:
	move	$t3,$0
	li	$t4,500
		while:
		sub	$t4,$t4,1
		for:
		addi	$t3,$t3,1

		
		blt	$t3,$t4,for
		nop
		bgez	$t4,while
		nop
		jr $ra
		nop	
bge