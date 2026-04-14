.section .rodata
file_name:
        .string "input.txt"
output_yes:
        .string "Yes\n"
output_no:
        .string "No\n"

.section .text
.globl main

main:

        addi sp,sp,-16
        sd x1,8(sp)

        addi x10,x0,-100
        la x11,file_name
        addi x12,x0,0
        addi x17,x0,56
        ecall

        addi x18,x10,0

        addi x10,x18,0
        addi x11,x0,0
        addi x12,x0,2
        addi x17,x0,62
        ecall

        addi x19,x0,0    #left

        addi x20,x10,-2  #right

        addi x24,x0,0    #counter

loop:

        bge x19,x20,check

        addi x10,x18,0
        addi x11,x19,0
        addi x12,x0,0
        addi x17,x0,62
        ecall

        addi x10,x18,0
        addi x11,sp,0
        addi x12,x0,1
        addi x17,x0,63
        ecall
        lb x22,0(sp)

        addi x10,x18,0
        addi x11,x20,0
        addi x12,x0,0
        addi x17,x0,62
        ecall

        addi x10,x18,0
        addi x11,sp,0
        addi x12,x0,1
        addi x17,x0,63
        ecall
        lb x23,0(sp)

        bne x22,x23,inc_cnt
        j continue

inc_cnt:
        addi x24,x24,1

continue:

        addi x19,x19,1
        addi x20,x20,-1
        j loop

check:

        beq x24,x0,YES
        la x10,output_no
        call printf
        j closing

YES:

        la x10,output_yes
        call printf

closing:

        addi x10,x18,0
        addi x17,x0,57
        ecall

        ld x1,8(sp)
        addi sp,sp,16
        jalr x0,0(x1)
