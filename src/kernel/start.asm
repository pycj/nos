[bits 32]
global _start
extern kernel_init

_start:
    push eax
    push ebx
    call kernel_init
    xchg bx,bx
    int 0xd
    ; mov bx,0
    ; div bx
    xchg bx,bx
    jmp $
