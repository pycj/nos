[org 0x1000]

db 0x55, 0xaa

;;;detect memory
mov si,detecting
call print

mov ax,0
mov es,ax
mov di,membuf
xor ebx,ebx
mov edx,0x534d4150
call detect_memory
xchg bx,bx

;;;loader kernel
mov si,loading
call print

mov ebx,5; sec num
mov edi,0x1000; addr
mov cl,200; sec count
call read_disk
;check
mov ax,0
mov ds,ax
cmp byte [ds:0000], 0x68; means 'h' of ascii
mov al,0
jne error

jmp protect_mode

detect_memory:
    mov ecx,20
    mov eax,0xe820
    int 0x15

    push eax
    mov al,1
    jc error
    pop eax

xchg bx,bx
    cmp ebx,0
    je .done

    add di,cx
    inc dword [ardscnt]
    jmp detect_memory
    .done:
ret

protect_mode:


read_disk:
    ; call .wait
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

error:
    cmp al,0
    je .loading
    cmp al,1
    je .detect
    .loading:
        mov si,loading_errormsg
        call print
        jmp .done
    .detect:
        mov si,detecting_errormsg
        call print
        jmp .done
    .done:
    hlt
    jmp $

print:
    mov ah,0x0e
    .next:
        mov al,[si]
        cmp al,0
        je .done
        int 0x10
        inc si
        jmp .next
    .done:
        ret

loading: db "loading nos......",10,13,0
loading_errormsg: db "loading nos error......",10,13,0
detecting: db "detecting memory......",10,13,0
detecting_errormsg: db "detecting memory error......",10,13,0

code_selector equ (1 << (3))
data_selector equ (2 <<(3))
video_selector equ (3 <<(3))

limit equ (1024 * 1024 * 1024) / (4 * 1024) - 1
base equ 0
code_type equ 0xa
data_type equ 0x2
gdtstart:
code_desc:
    dd ((base) & 0xff << 24) | 0xc | (limit & 0xf0000) \
    | 0x9 | code_type | (base & 0x00)
    dd (base & 0xffff) | (limit & 0x0ffff)
data_desc:
    dd ((base) & 0xff << 24) | 0xc | (limit & 0xf0000) \
    | 0x9 | data_type | (base & 0x00)
    dd (base & 0xffff) | (limit & 0x0ffff)
video_desc:
    dd ((base) & 0xff << 24) | 0xc | (limit & 0xf0000) \
    | 0x9 | data_type | (base & 0x0b)
    dd (base & 0x8fff) | (limit & 0x0ffff)
gdtend:

gdtptr:
    dd gdtstart
    dw gdtend - gdtstart -1
ardscnt:
    db 0
membuf: 