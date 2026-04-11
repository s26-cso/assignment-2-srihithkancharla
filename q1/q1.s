.text

.globl make_node
.globl insert
.globl get
.globl getAtMost

make_node:
        addi sp,sp,-16
        sd x1,0(sp)
        sw x10,8(sp)

        addi x10,x0,24

        call malloc
        ld x1,0(sp)
        lw x31,8(sp)

        sw x31,0(x10)
        sd x0,8(x10)
        sd x0,16(x10)

        addi sp,sp,16
        jalr x0,0(x1)

insert:
        addi sp,sp,-32
        sd x1,0(sp)
        sd x10,8(sp)
        sd x11,16(sp)

        beq x10,x0,root_is_null_insert

        lw x5,0(x10)
        ld x6,8(x10)
        ld x7,16(x10)

        blt x11,x5,val_lt_root_val_insert
        j val_ge_root_val_insert

val_lt_root_val_insert:
        addi x10,x6,0
        lw x11,16(sp)
        call insert

        ld x29,8(sp)
        sd x10,8(x29)
        j return_insert

val_ge_root_val_insert:
        addi x10,x7,0
        lw x11,16(sp)
        call insert

        ld x29,8(sp)
        sd x10,16(x29)

return_insert:
        ld x10,8(sp)
        ld x1,0(sp)
        addi sp,sp,32
        jalr x0,0(x1)

root_is_null_insert:
        ld x10,16(sp)
        call make_node
        ld x1,0(sp)
        addi sp,sp,32
        jalr x0,0(x1)

get:
        addi sp,sp,-32
        sd x1,0(sp)
        sd x10,8(sp)
        sd x11,16(sp)

        beq x10,x0,root_is_null_get

        lw x5,0(x10)
        ld x6,8(x10)
        ld x7,16(x10)

        blt x11,x5,val_lt_root_val_get
        bgt x11,x5,val_gt_root_val_get
        j val_eq_root_val_get

root_is_null_get:
        addi x10,x0,0
        ld x1,0(sp)
        addi sp,sp,32
        jalr x0,0(x1)

val_lt_root_val_get:
        addi x10,x6,0
        lw x11,16(sp)
        call get

        ld x1,0(sp)
        addi sp,sp,32
        jalr x0,0(x1)

val_gt_root_val_get:
        addi x10,x7,0
        lw x11,16(sp)
        call get

        ld x1,0(sp)
        addi sp,sp,32
        jalr x0,0(x1)

val_eq_root_val_get:
        ld x10,8(sp)
        ld x1,0(sp)
        addi sp,sp,32
        jalr x0,0(x1)

getAtMost:
        addi sp,sp,-32
        sd x1,0(sp)
        sd x10,8(sp)
        sd x11,16(sp)

        beq x11,x0,root_is_null_getAtMost

        lw x5,0(x11)
        ld x6,8(x11)
        ld x7,16(x11)

        blt x10,x5,val_lt_root_val_getAtMost
        bgt x10,x5,val_gt_root_val_getAtMost
        j val_eq_root_val_getAtMost

root_is_null_getAtMost:
        addi x10,x0,-1
        j finish_getAtMost

val_lt_root_val_getAtMost:
        addi x11,x6,0
        call getAtMost
        j finish_getAtMost

val_gt_root_val_getAtMost:
        addi x11,x7,0
        call getAtMost

        addi x29,x10,0
        addi x30,x0,-1

        beq x29,x30,temp_is_neg_one
        j finish_getAtMost

temp_is_neg_one:
        ld x11,16(sp)
        lw x10,0(x11)
        j finish_getAtMost

val_eq_root_val_getAtMost:
        addi x10,x5,0
        j finish_getAtMost

finish_getAtMost:
        ld x1,0(sp)
        addi sp,sp,32
        jalr x0,0(x1)
