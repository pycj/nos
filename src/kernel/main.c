#include "../include/types.h"
#include "../include/nos.h"
#include "../include/io.h"
#include "../include/string.h"
#include "../include/console.h"
#include "../include/stdarg.h"
#include "../include/assert.h"
#include "../include/debug.h"
#include "../include/global.h"
#include "../include/interrupt.h"
#include "../include/stdlib.h"
#include "../include/task.h"

u8 buf[1024];

void kernel_init() {
    console_init();
    gdt_init();
    interrupt_init();
    task_init();
    return;
}
