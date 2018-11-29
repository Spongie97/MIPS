# Change the Tab Size to 2 for better indent!
#

.data
	inputX: .asciiz "---- Least Common Multiple ----\nInput: \nx = "
	inputY: .asciiz "y = "
	result: .asciiz "Output:\nlcm(x,y) = "
	x: .word 0
	y: .word 0
.text
	main:	
		#	Prompt the user to enter x
		la 		$a0, inputX
		li 		$v0, 4
		syscall	

		# Input x, store the value at $s0 
		li 		$v0, 5
		syscall

		sw $v0, x
		move 	$s0, $v0

		#	Prompt the user to enter y
		la 		$a0, inputY
		li 		$v0, 4
		syscall	

		# Input y, store the value at $s1
		li 		$v0, 5
		syscall
		sw $v0, y
		move 	$s1, $v0

	while:
		div 	$s0, $s1				# t0 : r
		mfhi 	$t0							# r = x % y
		move	$s0, $s1				# x = y
		move 	$s1, $t0				# y = r
		beq 	$s1, 0, finish	# if y = 0, finish
		j 		while						# loop

	finish:
		# Print the result
		la 		$a0, result
		li 		$v0, 4
		syscall

		lw $a0, x
		lw $a1, y
		mul $a0, $a0, $a1
		div $a0, $a0, $s0	
		li		$v0, 1
		syscall	
		li 		$v0, 10
  		syscall							


