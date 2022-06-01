[bits 32]
global _start
extern kernel_init
extern console_init
_start:
    push eax
    push ebx
    call kernel_init
    call console_init
