# Change the Tab Size to 2 for better indent!
#
# Our recursive algorithm in C
# void hanoi (int num, char start, char tmp, char end ){#
#    if( num > 0 ){ 
#    	hanoi ( num-1 , start , end , tmp);
#    	cout << "Move " << start << "to " << end;
#    	hanoi ( num-1 , tmp , start , end);
#   }
# }
#--------------
# Stack Frame #
# 0			ra    #
# 4 		s0 		#
# 8			s1 		#
# 12		s2 		#
# 16		s3 		#
# 20  	a0 		#
# 24  	a1  	#
# 28  	a2 		#
# 32  	a3 		#
#--------------

.data
	input: .asciiz "---- Tower of honai ----\nInput:\nn = "
	output: .asciiz "Output:\n"
	move_d: .asciiz "move "
	newLine: .asciiz "\n"
	to: .asciiz " -> "
	towerA: .byte 'a'
	towerB: .byte 'b'
	towerC: .byte 'c'
	n: .word 0

.text
	main:
		#	Prompt the user to input
		la 		$a0, input
		li 		$v0, 4
		syscall	

		# System call code to read int 
		li 		$v0, 5
		syscall
		sw    $v0, n

		la    $a0, output
		li    $v0, 4
		syscall

		lw    $a0, n    			# move num to arg0
		lb		$a1, towerA			# put a into arg1
		lb		$a2, towerB			# put b into arg2
		lb		$a3, towerC			# put c into arg3
		jal 	hanoi						# starts hanoi

	exit:
	  li 		$v0, 10					# exit program
    syscall               

	hanoi:	
		# 	hanoi ( num-1 , start , end , tmp)		
		sub 	$sp, $sp, 4			# dec sp
		sw		$ra, ($sp)			# save return address on stack
		sub 	$sp, $sp, 4			# dec sp
		sw		$s0, ($sp)			# save s0 on stack
		sub 	$sp, $sp, 4			# dec sp
		sw		$s1, ($sp)			# save s1 on stack
		sub 	$sp, $sp, 4			# dec sp
		sw		$s2, ($sp)			# save s2 on stack
		sub 	$sp, $sp, 4			# dec sp
		sw		$s3, ($sp)			# save s3 on stack  
		sub 	$sp, $sp, 4			# dec sp
		beq  	$a0,0,zeroCase	# when num is 0
		sw		$a0, ($sp)			# store num on stack
		sub 	$sp, $sp, 4			# dec sp
		sw		$a1, ($sp)			# store "start" on stack
		sub 	$sp, $sp, 4			# dec sp
		sw		$a2, ($sp)			# store "tmp" on stack
		sub 	$sp, $sp, 4			# dec sp
		sw		$a3, ($sp)			# store "end" on stack
		sub 	$sp, $sp, 4			# dec sp	 	

		addi 	$a0, $a0, -1		# num = num - 1, put into arg0
		move 	$t0, $a2 				# put tmp to t0
		move 	$a2, $a3				# swap (a2,a3) :(tmp,end)
		move 	$a3, $t0
		jal 	hanoi						# Call hanoi

		addi 	$sp, $sp, 4			# inc sp
		lw 		$s0, ($sp)			# get s0 ="end" 	
		addi 	$sp, $sp, 4 		# inc sp
		lw 		$s1, ($sp)			# get s1 ="tmp"
		addi 	$sp, $sp, 4 		# inc sp
		lw 		$s2, ($sp)			# get s2 ="start"
		addi	$sp, $sp,4;			# inc sp 	
		lw		$s3,($sp)				# get num =s3

		# Print "Move " start  "to "  end
		la 		$a0, move_d
		li  	$v0, 4	
		syscall
		move 	$a0, $s2
		li 		$v0, 11
		syscall
		la 		$a0, to
		li  	$v0, 4	
		syscall
		move 	$a0, $s0
		li 		$v0, 11
		syscall
		li 	$v0, 4;       			
		la 	$a0, newLine    			
		syscall

		# 	hanoi ( num-1 , tmp , start , end)
		addi 	$a0, $s3, -1 		# arg0 = num - 1
		move 	$a1, $s1				# arg1 = tmp
		move 	$a2, $s2				# arg2 = start
		move  $a3, $s0 				# arg3 = end
		jal  	hanoi
	
	zeroCase:
		addi 	$sp, $sp, 20  	# Pop stack (s3,s2,s1,s0,ra)
		lw		$ra, ($sp)			# get return address off stack
		addi	$sp, $sp, 4			# inc sp back to where we expect it to start
		jr 		$ra							# back to caller