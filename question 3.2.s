.data

.text

main:
    li $t0, 0
    li $t1, 8
    li $t3, 10
      
while:

    add $t0, $t0, 1
    beq $t0, $t1, exit
    sub $t3, $t3, 1
    j while


 exit:   li $v0, 10
         syscall