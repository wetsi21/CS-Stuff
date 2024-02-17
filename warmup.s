.data
   
.text
    .globl main

main:
    
    li $t0, 23

   
    li $t1, 46   
    add $t1, $t1, $t0  

    li $v0, 10 
    syscall
