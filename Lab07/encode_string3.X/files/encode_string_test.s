###########################################################################
#
#    ECE 212 Lab 7 - Fall 2023
#    encode_string test file
#
########################################################################### 

  .set noreorder
    .global main         # define main as a global label
    .text
main: 
    la   $a0, msg        # put string address in argument register $a0
    addi $a1, $zero, 4   # put character shift amount in arg reg $a1
    jal  encode_string   # call the function
    add  $0, $0, $0      # branch delay slot nop
now_decode:
    la   $a0, msg        # put string address in argument register $a0
    addi $a1, $zero, -4  # put character shift amount in arg reg $a1
    jal  encode_string   # call the function
    add  $0, $0, $0      # branch delay slot nop
done:  
    j done               # infinite loop
    add $0, $0, $0       # branch delay slot

###########################################################################
#
#    Add assembly code for encode_char function here
#
###########################################################################
        
encode_char:
    addi $t4, $0, 91
    add $t5, $0, $0
    slti $t0, $t6, 65
    slt $t1, $t4, $t6
    beq $t1, $t0, imm
    add $0, $0, $0
    add $v0, $t6, $0
    jr $ra
    add $0, $0, $0
imm:
    add $t2, $a1, $t6
    slt $t3, $t2, $t4
    beq $t3, $t5, high_char
    add $0, $0, $0
    add $v0, $t2, $0
    jr $ra
    add $0, $0, $0
high_char:
    addi $t2, $t2, -26
    add $v0, $t2, $0
    jr $ra
    add $0, $0, $0

    
###########################################################################
#
#    Add assembly code for encode_string function here
#
###########################################################################  

encode_string:
    
    addi $sp, $sp, -8
    sw $a0, 0($sp)
    sw $ra, 4($sp)
    lb $t6, 0($a0)
    add $0, $0, $0
    jal encode_char
    add $0, $0, $0
    sb $v0, 4($sp)
    add $0, $0, $0
    # add $t6, $0, $a0
    # add $t7, $0, $ra
    lw $a0, 0($sp)
    lw $ra, 4($sp)
    


###########################################################################
#
#    data segment assembler directives to allocate storage for string msg
#
########################################################################### 
    
      .data
msg:
      .asciz "WELCOME BACK MY FRIENDS 2 THE show THAT NEVER ENDS"


