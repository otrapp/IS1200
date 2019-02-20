  # analyze.asm
  # This file written 2015 by F Lundevall
  # Copyright abandoned - this file is in the public domain.

	.text
main:
	li	$s0,0x30	#48 �r platsen f�r tecknet 0
loop:
	move	$a0,$s0								# copy from s0 to a0
	
	li	$v0,11								# syscall with v0 = 11 will print out
	syscall									# one byte from a0 to the Run I/O window
		
	addi	$s0,$s0,3	# l�gg till 3 till s0				# what happens if the constant is changed?
	
	li	$t0,0x5b        #Z har plats 90 i ASCII 0x5b=91
	ble	$s0,$t0,loop    #branch if t0 is less or equal than s0
	nop									# delay slot filler (just in case)

stop:	j	stop								# loop forever here
	nop									# delay slot filler (just in case)



				# The lines changes are 14, an 17. 14 to add 3 to the saved temporary0 instead of 1.
				# 17 to change the conditions of exiting the loop, comparing t0 as being less or equal instead of brancing on simply not equal
				# as the change on line 14 of adding 3 makes the conditions for bne never occur as it jumps over the value compared to. 
				
				#