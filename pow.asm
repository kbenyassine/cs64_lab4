# pow.asm program
#

# C++ (NON-RECURSIVE) code snippet of pow(x,n):
#   int x, n, pow=1; 
#   cout << "Enter a number x:\n"; 
#   cin >> x;
#   cout << "Enter the exponent n:\n"; 
#   cin >> n; 
#   for (int i = 1; i <= n; i++) { 
#   	pow = pow * x; 
#   } 
#   cout << "Power(x,n) is:\n" << pow << "\n";
#
# Assembly (NON-RECURSIVE) code version of pow(x,n):
#
.data

    enter_num: .asciiz "Enter a number x:\n"
    exp_num: .asciiz "Enter the exponent n:\n"
    pow: .asciiz "Power(x,n) is:\n"
	new_line: .asciiz "\n"
	# TODO: Write your initializations here

#Text Area (i.e. instructions)
.text
main:
	li $v0 4
	la $a0 enter_num
	syscall
	li $v0 5
	syscall
	move $t0 $v0

	li $v0 4
	la $a0 exp_num
	syscall
	li $v0 5
	syscall
	move $t1 $v0

	li $t2 1
	li $t3 1

	loop:
	bgt $t3 $t1 exit
	mult $t0 $t2
	mflo $t2
	addi $t3 $t3 1
	j loop


	# TODO: Write your code here

exit:
	# TODO: Write code to properly exit a SPIM simulation
	li $v0 4
	la $a0 pow
	syscall 
	li $v0 1
    move $a0 $t2
    syscall
	li $v0 10
    syscall
