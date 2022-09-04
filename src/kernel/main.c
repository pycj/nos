#include "../include/nos.h"
#include "../include/types.h"
#include "../include/io.h"
#include "../include/string.h"
#include "../include/console.h"
#include "../include/stdarg.h"
#include "../include/assert.h"
#include "../include/debug.h"
#include "../include/global.h"
#include "../include/interrupt.h"
#include "../include/stdlib.h"

u8 message[] = "Hello, Nos\n";
u8 buf[1024];

void kernel_init() {
    console_init();
    gdt_init();
    interrupt_init();
    asm volatile("sti\n"
                "movl %eax, %eax\n");
    u32 counter = 0;
    while (true) {
        DEBUGK("looping in kernel init %d...\n", counter++);
        delay(0xffffffff);
    }
    return;
}
