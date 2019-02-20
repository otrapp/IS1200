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
.global
  
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
		.global delay
delay: 
	move $t0, $0
	li $t1, 800 #constant
	while:
		sub $t1,$t1,1
		for:
		nop	
		addi $t0,$t0,1
		blt $t0,$t1,for
		nop
		bgez $t1,while
		nop
	jr $ra
	nop
		.global time2string
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
	jal hexasc
	nop
	sb $v0,4($s0)
			# #lit zer0
	sb $0,5($s0)	
	POP $ra
	POP $s1
	POP $s0
	jr $ra
	nop
