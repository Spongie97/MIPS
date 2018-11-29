.data

	str: .asciiz "---- Josephus Problem ----\nInput: \n"
	str1: .asciiz "n = "
	str2: .asciiz "k = "
	str3: .asciiz "Output: \nLast suvivor = "
	newline: .asciiz "\n"

.text

	main:
		li $v0, 4
		la $a0, str
		syscall

		li $v0, 4
		la $a0, str1
		syscall

		li $v0, 5     #Input n
		syscall

		move $a1, $v0

		li $v0, 4
		la $a0, str2
		syscall

		li $v0, 5      #Input k
		syscall
		move $a2, $v0

		li $t4, 0      #int g = 0
		li $t5, 1      #int i = 1
		jal loop

		li $v0, 10
		syscall

	loop:
		bgt $t5,$a1,cout 
		add $t0,$a2,$t4
		div $t0,$t5
		mfhi $t4
		addi $t5,$t5,1

		j loop

	cout:
		move $t7,$t4
		addi $t7,$t7,1

		li $v0,4
		la $a0, str3
		syscall

		li $v0,1
		move $a0, $t7
		syscall

		li $v0,4
		la $a0, newline
		syscall

		j main