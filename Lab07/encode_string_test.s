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
    add $s0, $0, $0
    addi $s1, $0, 1
    addi $s2, $0, 2
    la   $a0, msg        # put string address in argument register $a0
    addi $a1, $zero, 4   # put character shift amount in arg reg $a1
    addi $t9, $t9, 1
    jal  encode_string   # call the function
    add  $0, $0, $0      # branch delay slot nop
    add $0, $0, $0
    
now_decode:
    la   $a0, msg        # put string address in argument register $a0
    addi $a1, $zero, -4  # put character shift amount in arg reg $a1
    addi $t9, $t9, 1
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
    #UpperCase Lettering
    addi $t4, $0, 91
    add $t5, $0, 65
    slt $t0, $t6, $t5
    slt $t1, $t4, $t6
    beq $t1, $t0, imm
    add $0, $0, $0
    #LowerCase Lettering
    addi $t4, $0, 123
    addi $t5, $0, 97
    slt $t0, $t6, $t5
    slt $t1, $t4, $t6
    beq $t1, $t0, imm
    add $0, $0, $0
    #Encodes characters that are not the SPACE key
    addi $t7, $0, 32
    addi $t4, $0, 33
    addi $t5, $0, 127
    bne $t6, $t7, imm
    add $0, $0, $0
    add $v0, $t6, $0
    jr $ra
    add $0, $0, $0
imm:
    add $t2, $a1, $t6
    slt $t3, $t2, $t4
    beq $t3, $s0, high_char
    add $0, $0, $0
    slt $t3, $t2, $t5
    beq $t3, $s1, low_char
    add $0, $0, $0
    add $v0, $t2, $0
    jr $ra
    add $0, $0, $0
high_char:
    addi $t2, $t2, -26
    add $v0, $t2, $0
    jr $ra
    add $0, $0, $0
low_char:
    addi $t2, $t2, 26
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
    lbu $t8, 0($a0) # dereference the pointer
    beq $t8, $0, ret # we're done when we read '\0'
    add $0, $0, $0 # branch delay slot
    sw $a0, 0($sp)
    sw $ra, 4($sp)
    lb $t6, 0($a0)
    add $0, $0, $0
    jal encode_char
    add $0, $0, $0
    sb $v0, 0($a0)
    add $0, $0, $0
    lw $a0, 0($sp)
    lw $ra, 4($sp)
    addi $v0, $v0, 1 # i++
    addi $a0, $a0, 1 # s++
    j encode_string
    add $0, $0, $0 # branch delay slot  
ret:
    beq $t9, $s1, jDecode
    add $0, $0, $0
    beq $t9, $s2, jDone
    add $0, $0, $0

jDecode:
    j now_decode # at end of string - return
    add $0, $0, $0 # branch delay slot
jDone:  
    j done # at end of string - return
    add $0, $0, $0 # branch delay slot
    
    
    
    
    
    
###########################################################################
#
#    data segment assembler directives to allocate storage for string msg
#
########################################################################### 
    
      .data
msg:
      .asciz "WELCOME BACK MY FRIENDS 2 THE show THAT NEVER ENDS"


