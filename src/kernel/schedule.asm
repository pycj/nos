global task_switch

task_switch:
    push ebp
    mov ebp,esp

    push ebx
    push esi
    push edi

    mov eax,esp
    and eax,0xfffff000

    mov [eax],esp ; 保存当前stack的栈顶指针到当前页面的底部

    mov eax,[ebp+8] ; 拿到传进来的要切换的task 的栈顶指针
    mov esp,[eax]; 把要切换的task的栈顶指针赋值给sp

    pop edi 
    pop esi
    pop ebx
    pop ebp

    ret
