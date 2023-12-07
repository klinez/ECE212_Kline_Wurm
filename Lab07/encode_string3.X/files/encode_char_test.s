###########################################################################
#
#    ECE 212 Lab 7 - Fall 2023
#    encode_char test file
#
########################################################################### 
 
    .set noreorder
    .global main             # define main as a global label
    .text
main: 
    addi $a0, $0, 'A'        # put character to encode in $a0
    addi $a1, $zero, 4       # put character shift amount in arg reg $a1
    jal  encode_char         # call the function
    add  $0, $0, $0          # branch delay slot nop
encode_another:
    addi $a0, $0, 'Z'        # put character to encode in $a0
    addi $a1, $zero, 4       # put character shift amount in arg reg $a1
    jal  encode_char         # call the function
    add  $0, $0, $0          # branch delay slot nop
done:  
    j done                   # infinite loop
    add $0, $0, $0           # branch delay slot

###########################################################################
#
#    Add your encode_char assembly code below this comment
#
###########################################################################
    
encode_char:
    addi $t4, $0, 91
    add $t5, $0, $0
    slti $t0, $a0, 65
    slt $t1, $t4, $a0
    beq $t1, $t0, imm
    add $0, $0, $0
    add $v0, $a0, $0
    jr $ra
    add $0, $0, $0
imm:
    add $t2, $a1, $a0
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