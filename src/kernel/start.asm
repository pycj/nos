[bits 32]
global _start
extern kernel_init

_start:
    push eax
    push ebx
    call kernel_init
    int 80
    jmp $
