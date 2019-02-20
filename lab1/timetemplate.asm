  # timetemplate. asm
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
mytime:	.word 0x5957 #0x5957
timstr:	.ascii "text more text lots of text\0"
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
	la	$a0,timstr
	la	$t0,mytime
	lw	$a1,0($t0)
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
	andi	$t1,$t0,0xf	# check lowest value digit 
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

  # you can write your code for subroutine "hexasc" below this line
  #
hexasc:
	andi $t0,$a0,0xf
	li $t1, 9
	ble $t0, $t1, small
	nop	
	addi $v0,$t0,0x37
	jr $ra
	nop

	small:
	addi $v0,$t0,0x30
	jr $ra
	nop

delay: 
	move $t3, $0
	li $t4, 1 #constant
	while:
		sub $t4,$t4,1
		for:
		nop	
		addi $t3,$t3,1
		blt $t3,$t4,for
		nop
		bgez $t4,while
		nop
	jr $ra
	nop
	
time2string:
			#Första minuten
	PUSH $s0
	PUSH $s1
	PUSH $ra
	move $s0, $a0
	move $s1, $a1	
	srl $a0,$s1,12
	jal hexasc
	nop
	sb $v0,0($s0)
			#Andra minuten
	srl $a0,$s1,8
	jal hexasc
	nop
	sb $v0,1($s0)
			#Kolon
	li $t0, 0x3A
	sb $t0,2($s0)
			#Första sekunden
	srl $a0,$s1,4
	jal hexasc
	nop
	sb $v0,3($s0)
			#Andra sekunden	
	srl $a0,$s1,0
	andi $t0,$a1,0xf000 	
	jal hexasc
	nop
	beq $a1, 0x32, two
	nop
	sb $v0,4($s0)
	
			
	sb $0,5($s0) 	#null byte
	POP $ra
	POP $s1
	POP $s0
	jr $ra
	nop
	two:	
		li $t0, 0x54 	# T
		sb $t0,4($s0)
		nop
		li $t0,0x57	# W 
		sb $t0,5($s0) 
		nop
		li $t0, 0x4F	# O
		sb $t0,6($s0)  
		nop
		sb $0,7($s0)    #conditional null byte
		POP $ra
		POP $s1
		POP $s0
		jr $ra
		nop