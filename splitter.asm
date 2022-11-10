.data
#DO NOT CHANGE
buffer: .word 0:100
array: .word 9 1 2 1 17 19 10 9 11 10
newline: .asciiz "\n"
comma: .asciiz ", "
convention: .asciiz "Convention Check\n"
depth: .asciiz "depth "
colon: .asciiz ":"



.text
    main:
        la $a0 array #the input array
        li $a1 2 #depth: number of times you need to split an array
        la $a2 buffer #the buffer array address
        li $a3 10 #array length        
        move $s0 $a0
        move $s1 $a1
        move $s2 $a2
        move $s3 $a3
        ori $s4 $0 0
        ori $s5 $0 0
        jal disaggregate

        j exit
    
    disaggregate:
        addiu $sp $sp -28 #?? = the negative of how many values we store in (stack * 4)
        
        #store all required values that need to be preserved across function calls
        
        #store array address on stack s0
        #store n on stack s1
        #store buffer pointer on stack s2
        #store length of array on stack s3
        sw $s0 0($sp) 
        sw $s1 4($sp)
        sw $s2 8($sp)
        sw $s3 12($sp)

        #Since our array_len parameter becomes small/big array len
        #We need them to be what they were before the next recursive call!

        #store small array length on stack
        #store big array length on stack
        sw $s4 16($sp)
        sw $s5 20($sp)

        #multiple function calls overwrite ra, therefore must be preserved
        #store return address
        sw $ra 24($sp)

        #print depth value  according to expected format
        la $a0  depth    
        li $v0  4
        syscall
        li $v0  1
        move $a0  $s1
        syscall
        la $a0  colon    
        li $v0 4
        syscall
        
        #Don't forget to define your variables!
        li $t7 1 #i
        li $t2 0 #sum
        addiu $t0 $s0 0 #array indexing

        #It's dangerous to go alone  take this one loop for free
        #please enjoy and use carefully
        #this code makes no assumptions on your code
        #fix this code to work with yours or vice versa
        #don't have to use this loop either can make your own too
        
        loop:
            #find sum
            bgt $t7  $s3  func_check #this is the loop exit condition
            lw $t6  0($t0)
            
            #print array entry
            li $v0  1
            move $a0  $t6
            syscall
            li $v0  4
            la $a0  comma
            syscall
            
            addi $t0  $t0  4
            addi $t7  $t7  1
            add $t2  $t2  $t6
            j loop

        func_check:
            #Add the recursive function end condition
            #Needs to exist so that we don't end up recursing to infinity!
            #This is the recursive equivalent to our iteration condition
            #for example the i < 10 in a for/while loop
            #We have two recursive conditions: depth == 0  arr_len == 1
            #They are OR'd in the C/C++ template
            #Do you need to OR them in MIPs too? 
    
            li $t9 1
            li $t8 0

            beq $s1 $t8 function_end
            beq $s3 $t9 function_end

        #calculate the average 
        div $t2 $s3 #what register do we divide by? 
        mflo $t3 #avg 

        #This is the main loop  not for free :/
        addiu $t0 $s0 0 #array
        addiu $t1 $s2 0 #small
        addiu $t2 $s2 40 #big
        li $t5 0 #i
        li $t6 0 #j
        li $t7 0 #k

        loop2:
            #find big and small array
            bge $t5 $s3 closing #this is the loop exit condition
            #Remember the conditions for splitting
            #if entry <= average put in small array
            #if entry > average put in big array

            lw $t4 0($t0)
            bgt $t4 $t3 greater_than
            addi $t6 $t6 1
            sw $t4 0($t1)

            addi $t0  $t0  4
            addi $t1  $t1  4
            addi $t5  $t5  1

            j loop2

        closing:
        #This is the section where we prepare to call the function recursively.
        
            move $s4  $t6 #save the small array length value 
            move $s5  $t7 #save the big array length value

            jal ConventionCheck #DO NOT REMOVE 

            #Make sure your $s registers have the correct values before calling
            #Remember we recursively call with small array first
            #So load small array arguments in $s registers
            
            #This is updating the buffer so that we don't overwrite our old values
            move $s0 $s2
            addiu $s2  $s2  80
            #We call small array first so we load small array length as arr_len
            move $s3  $s4 

            addiu $s1 $s1 -1

            jal disaggregate

            jal ConventionCheck #DO NOT REMOVE
            
            #Similarly for big array we mirror the call structure of small array as above
            #But with the values appropriate for big array. 

            lw $s1 4($sp)
            addiu $s1 $s1 -1

            lw $s2 8($sp)

            addiu $s2  $s2  40
            move $s0 $s2
            addiu $s2  $s2  80
            move $s3  $s5 #big array call second
            
            jal disaggregate

            j function_end
        
        function_end:
        #Here we reset our values from previous iterations
        #Be careful on which values you load before and after the $sp update if you have to 
        #We can accidentally end up loading values of current calls instead of previous calls
        #Manually drawing out the stack changes helps figure this step out
            lw $s0  0($sp)
            lw $s1  4($sp)
            lw $s2  8($sp)
            lw $s3  12($sp)
            lw $s4  16($sp)
            lw $s5  20($sp)
            lw $ra  24($sp)
            #Load values before update if you have to
            addiu $sp $sp 28 #?? = the positive of how many values we store in (stack * 4)
            #Load values after update if you have to
            jr $ra
        
    
    exit:
        li $v0  10
        syscall

ConventionCheck:  
#DO NOT CHANGE AUTOGRADER USES THIS  
    #reset all temporary values
    addi    $t0  $0  -1
    addi    $t1  $0  -1
    addi    $t2  $0  -1
    addi    $t3  $0  -1
    addi    $t4  $0  -1
    addi    $t5  $0  -1
    addi    $t6  $0  -1
    addi    $t7  $0  -1
    ori     $v0  $0  4
    la      $a0  convention
    syscall
    addi    $v0  $zero  -1
    addi    $v1  $zero  -1
    addi    $a0  $zero  -1
    addi    $a1  $zero  -1
    addi    $a2  $zero  -1
    addi    $a3  $zero  -1
    addi    $k0  $zero  -1
    addi    $k1  $zero  -1
    jr      $ra


greater_than:
        addi $t7 $t7 1
        sw $t4 0($t2)

        addi $t0  $t0  4
        addi $t2  $t2  4
        addi $t5  $t5  1
        j loop2
