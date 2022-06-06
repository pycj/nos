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

;;enter protect mode and loader kernel
mov si,loading
call print
jmp protect_mode

detect_memory:
    mov ecx,20
    mov eax,0xe820
    int 0x15


    jc error
    
    cmp ebx,0
    je .done

    add di,cx
    inc dword [ardscnt]
    jmp detect_memory
    .done:
ret

error:
    mov si,detecting_errormsg
    call print
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

protect_mode:
    cli
    in al, 0x92
    or al,10b
    out 0x92,al

    lgdt [gdtptr]
    mov eax,cr0
    or eax,1b
    mov cr0,eax

    jmp dword code_selector:prot

[bits 32]

    prot:
        mov ax,data_selector
        mov ds,ax
        mov es,ax
        mov gs,ax
        mov fs,ax
        mov ss,ax
        mov esp,0x10000

        mov ebx,5; sec num
        mov edi,0x10000; addr
        mov cl,200; sec count
        call read_disk

        mov eax,0x68686169
        mov ebx,ardscnt
        jmp 0x10000
        ud2

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

loading: db "loading nos......",10,13,0
detecting: db "detecting memory......",10,13,0
detecting_errormsg: db "detecting memory error......",10,13,0

code_selector  equ (1 << 3)
data_selector  equ (2 << 3)

; limit equ (1024 * 1024 * 1024 * 4) / (4 * 1024) - 1
limit equ 0xffffffff
base equ 0
code_type equ 0xa
data_type equ 0x2
gdtstart:
null_desc:
    dd 0
    dd 0
code_desc:
    dw limit & 0xffff
    dw base & 0xffff
    db (base >> 16) & 0xff
    db 0x90 | code_type
    db 11000000b | ((limit >> 16) & 0xf)
    db (base >> 24) & 0xff
data_desc:
    dw limit & 0xffff
    dw base & 0xffff
    db (base >> 16) & 0xff
    db 0x90 | data_type
    db 11000000b | ((limit >> 16) & 0xf)
    db (base >> 24) & 0xff
video_desc:
    dw 0x0007
    dw 0x8000
    db 0x0b
    db 0x90 | data_type
    db 11000000b
    db 0
gdtend:

gdtptr:
    dw gdtend - gdtstart -1
    dd gdtstart
ardscnt:
    dd 0
membuf: 