[bits 32]

global outb
global outw
global inb
global inw

outb:
    push ebp
    mov ebp, esp
    mov dx,[ebp + 8]
    mov al,[ebp + 0xc]
    out dx,al
    leave
    ret

outw:
    push ebp
    mov ebp, esp
    mov dx,[ebp + 8]
    mov ax,[ebp + 0xc]
    out dx,ax
    leave
    ret

inb:
    push ebp
    mov ebp,esp
    xor eax,eax
    mov dx,[ebp + 8]
    in al,dx
    leave
    ret

inw:
    push ebp
    mov ebp,esp
    xor eax,eax
    mov dx,[ebp + 8]
    in ax,dx
    leave
    ret
