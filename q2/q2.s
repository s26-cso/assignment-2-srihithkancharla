.section .rodata
fmt:      .string "%lld "
fmt_no_space: .string "%lld\n" 
 
.section .text
.globl main

main:

        addi sp,sp,-32
        sd x1,24(sp)
        addi x18,x10,0
        addi x19,x11,0

        li x31,24
        mul x31,x31,x18
        addi x31,x31,15
        andi x27,x31,-16

        sub sp,sp,x27
        addi x26,sp,0
        addi x20,sp,0
        addi x21,sp,0

        addi x22,x18,-1

loop1:

        li x31,1
        blt x22,x31,conclude

loop2:

        beq x20,x26,continue

        slli x31,x22,3
        add x31,x19,x31
        ld x10,0(x31)

        addi sp,sp,-16
        sd x1,0(sp)
        call atoi
        ld x1,0(sp)
        addi sp,sp,16
        addi x23,x10,0

        addi x31,x20,-16
        ld x10,0(x31)

        addi sp,sp,-16
        sd x1,0(sp)
        call atoi
        ld x1,0(sp)
        addi sp,sp,16
        addi x24,x10,0

        bgt x24,x23,continue

        addi x20,x20,-24
        j loop2

continue:

        beq x20,x26,stack_is_empty

stack_not_empty:

        addi x31,x20,-24
        ld x25,0(x31)
        sd x25,16(x21)
        j end_of_loop1

stack_is_empty:

        li x30,-1
        sd x30,16(x21)

end_of_loop1:

        sd x22,0(x20)

        slli x31,x22,3
        add x31,x19,x31
        ld x10,0(x31)
        sd x10,8(x20)

        addi x20,x20,24
        addi x21,x21,24
        addi x22,x22,-1
        j loop1

conclude:

        addi x22,x18,-1
        addi x21,x21,-24

print_loop:

        li x31,0
        ble x22,x31,done_print

        ld x11,16(x21)

        li x31,-1
        beq x11,x31,skip_sub
        addi x11,x11,-1

skip_sub:

        li x31,1
        beq x22,x31,use_no_space

        la x10,fmt
        j do_print

use_no_space:
        la x10,fmt_no_space

do_print:
        addi sp,sp,-16
        sd x1,0(sp)
        call printf
        ld x1,0(sp)
        addi sp,sp,16

        addi x21,x21,-24
        addi x22,x22,-1
        j print_loop

done_print:

        add sp,sp,x27
        ld x1,24(sp)
        addi sp,sp,32
        jalr x0,0(x1)
