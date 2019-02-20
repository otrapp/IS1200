# hexmain.asm
  # Written 2015-09-04 by F Lundevall
  # Copyright abandonded - this file is in the public domain.

.text
main:
	li	$a0,0		# change this to test different values

	jal	hexasc		# call hexasc
	nop			# delay slot filler (just in case)

	move	$a0,$v0		# copy return value to argument register

	li	$v0,11		# syscall with v0 = 11 will print out
	syscall			# one byte from a0 to the Run I/O window
	
stop:	j	stop		# stop after one run
	nop			# delay slot filler (just in case)

  # You can write your own code for hexasc here
# Must have parameter: $a0; Return value as an ASCII character in register $v0, no other bits;	
hexasc:
	andi $t0,$a0,0xf
	li $t1, 9
	ble $t0, $t1, small
	
	addi $v0,$t0,0x37
	jr $ra

small:
	addi $v0,$t0,0x30
	jr $ra
