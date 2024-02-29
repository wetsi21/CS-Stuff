    .data
numbers:
    .space 40       # space for 10 numbers (each number is 4 bytes)
newline:
    .asciiz "\n"
prompt1:
    .asciiz "Enter number "
prompt2:
    .asciiz "Enter the search number: "
found_message:
    .asciiz " is found at index "
not_found_message:
    .asciiz "Not found"

    .text
    .globl main

main:
    # Prompt user for 10 numbers
    li $t0, 0          # loop counter
    la $t1, numbers    # load base address of numbers array
    
prompt_loop:
    bge $t0, 10, input_search_number  # if loop counter >= 10, jump to input search number
    li $v0, 4
    la $a0, prompt1
    syscall
    
    li $v0, 5           # read integer
    syscall
    sw $v0, 0($t1)      # store number at current index
    addi $t0, $t0, 1    # increment loop counter
    addi $t1, $t1, 4    # move to next index
    j prompt_loop
    
input_search_number:
    # Prompt user for search number
    li $v0, 4
    la $a0, prompt2
    syscall
    
    li $v0, 5           # read integer
    syscall
    move $s1, $v0       # store search number in $s1
    
    # Search for the number in the array
    li $t0, 0           # reset loop counter
    la $t1, numbers     # load base address of numbers array
    
search_loop:
    bge $t0, 10, not_found  # if loop counter >= 10, jump to not_found
    lw $t2, 0($t1)      # load number at current index
    beq $s1, $t2, found  # if search number == current number, jump to found
    addi $t0, $t0, 1    # increment loop counter
    addi $t1, $t1, 4    # move to next index
    j search_loop
    
found:
    # Print index of found number
    li $v0, 1
    move $a0, $t0       # index of found number
    syscall
    li $v0, 4
    la $a0, found_message
    syscall
    j end_program
    
not_found:
    # Print "Not found" message
    li $v0, 4
    la $a0, not_found_message
    syscall
    
end_program:
    # Exit program
    li $v0, 10
    syscall
