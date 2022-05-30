[org 0x7c00]

cli

mov ax,0
mov ds,ax
mov es,ax
mov ss,ax
mov sp,0x7c00

mov si,booting
call print

mov ebx,1; sec num
mov edi,0x1000; addr
mov cl,4; sec count
call read_disk

cmp word [0x1000],0xaa55
jne error

jmp 0x1002
jmp $

read_disk:
    .write:
        mov dx,0x1f2
        mov al,cl
        out dx,al

        mov dx,0x1f3
        mov al,bl
        out dx,al

        mov dx,0x1f4
        shr ebx,8
        mov al,bl
        out dx,al

        mov dx,0x1f5
        shr ebx,8
        mov al,bl
        out dx,al

        mov dx,0x1f6
        shr ebx,8
        mov al,bl
        and al,00001111b
        add al,11100000b

        out dx,al

        mov dx,0x1f7
        mov al,0x20
        out dx,al
    .read:
        call .wait

        push cx
        call .read_write
        pop cx

        loop .read
ret

    .wait:
        mov dx,0x1f7
        in al,dx
        and al,10001000b
        cmp al,00001000b
        jne .wait
        ret
    .read_write:
        mov cx,256
        .read_write_start:
            mov dx,0x1f0
            in ax,dx
            mov [ds:edi],ax
            add edi,2
            loop .read_write_start
        ret

print:
    mov ah,0x0e
.next:
    mov al,[si]
    cmp al,0
    jz .done
    int 0x10
    inc si
    jmp .next
.done:
ret

error:
    mov si,errormsg
    call print
    hlt
    jmp $
ret

booting: db "boot nos......",10,13,0
errormsg: db "boot nos error......",10,13,0

times 510-($-$$) db 0
db 0x55, 0xaa