# min.asm program
#

.data

        # TODO: Complete these declarations / initializations

        enter_num: .asciiz "Enter the next number:\n"
        new_line: .asciiz "\n"
        minimum: .asciiz "Minimum: "

#Text Area (i.e. instructions)
.text

main:

    # TODO: Write your code here
    # You can have other labels expressed here, if you need to
        li $v0 4
        la $a0 enter_num
        syscall
        li $v0 5
        syscall
        move $t0 $v0

        li $v0 4
        la $a0 enter_num
        syscall
        li $v0 5
        syscall
        move $t1 $v0

        li $v0 4
        la $a0 enter_num
        syscall
        li $v0 5
        syscall
        move $t2 $v0

        blt $t0 $t1 first_register
        blt $t1 $t2 second_register
	j third

third:
        li $v0 4
        la $a0 minimum
        syscall
        li $v0 1
        move $a0 $t2
        syscall
        j exit

first_register:
	blt $t0 $t2 first_final	
	j third


first_final:
        li $v0 4
        la $a0 minimum
        syscall
        li $v0 1
        move $a0 $t0
        syscall
        j exit


second_register:
	blt $t1 $t0 second_final
	j first_final

second_final:
	 li $v0 4
        la $a0 minimum
        syscall
        li $v0 1
        move $a0 $t1
        syscall
        j exit

exit:
	li $v0 10
        syscall
