.data
comma:      .asciiz ", "
newline:      .asciiz "\n"
encrypt: .asciiz "Encrypted: "
decrypt: .asciiz "Decrypted: "
krabby: .word 1 2 3 4 5 6 7 8 9 10

carray: .word 0:10

marray: .word 0:10

.text
main:
	la $s5 krabby

	la $s6 carray
	la $s7 marray
	
	li $a0 3 # argument a
	li $a1 11 # argument b

	li $t6 10 #break loop
	li $t7 0 #i

	addiu $t1 $s6 0 #array for carray
	addiu $t0 $s5 0 #array for krabby

	loop_app:
		bge $t7 $t6 continue
		lw $a2 0($t0)
		jal secret_formula_apply
		sw $v0 0($t1)
		addiu $t1 $t1 4
		addiu $t0 $t0 4
		addi $t7 $t7 1
		j loop_app

	continue: 

	li $t6 10 #break loop
	li $t7 0 #i

	addiu $t1 $s7 0 #array for marray
	addiu $t2 $s6 0 #array for carray


	loop_rem:
		bge $t7 $t6 exit
		lw $a2 0($t2)
		jal secret_formula_remove
		sw $v0 0($t1)
		addiu $t1 $t1 4
		addiu $t2 $t2 4
		addi $t7 $t7 1
		j loop_rem



secret_formula_apply:
#fill stuff here thanks
	#addiu $sp, $sp, -4
	#sw $ra, 0($sp)

	li $t3 7 #variable e

	mult $a0 $a1
	mflo $t4

	li $t5 1 
	li $s3 1

	loop_powone:
		bgt $s3 $t3 cont_one
		mult $a2 $t5
		mflo $t5
		addi $s3 $s3 1
		j loop_powone

	cont_one:

	div $t5 $t4
	mfhi $s4

	move $v0 $s4
	#lw $ra, 0($sp)
	#addiu $sp, $sp, 4
	jr $ra

secret_formula_remove:
#fill more stuff here thanks
	#addiu $sp, $sp, -4
	#sw $ra, 0($sp)

	li $t3 3

	mult $a0 $a1
	mflo $t4

	li $t5 1
	li $s3 1

	loop_powtwo:
	bgt $s3 $t3 cont_two
	mult $a2 $t5
	mflo $t5
	addi $s3 $s3 1
	j loop_powtwo

	cont_two:

	div $t5 $t4
	mfhi $s4

	move $v0 $s4
	#lw $ra, 0($sp)
	#addiu $sp, $sp, 4
	jr $ra



exit:	
		li $v0 4
		la $a0 encrypt
		syscall

        la $t0, carray

        li $v0, 1
        lw $a0, 0($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall
        
        li $v0, 1
        lw $a0, 4($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 8($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 12($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 16($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 20($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 24($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 28($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 32($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall
		
	li $v0, 1
        lw $a0, 36($t0)
        syscall
	li $v0, 4
    la $a0, newline
    syscall

	li $v0 4
		la $a0 decrypt
		syscall

        la $t1, marray

        li $v0, 1
        lw $a0, 0($t1)
        syscall
        li $v0, 4
        la $a0, comma
        syscall
        
        li $v0, 1
        lw $a0, 4($t1)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 8($t1)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 12($t1)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 16($t1)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 20($t1)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 24($t1)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 28($t1)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 32($t1)
        syscall
        li $v0, 4
        la $a0, comma
        syscall
		
	li $v0, 1
        lw $a0, 36($t1)
        syscall

	li $v0, 10
	syscall


