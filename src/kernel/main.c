#include "../include/nos.h"
#include "../include/types.h"
#include "../include/io.h"
#include "../include/string.h"
#include "../include/console.h"
#include "../include/stdarg.h"

u8 message[] = "Hello, world\n";
u8 buf[1024];

void test_args(int cnt, ...) {
    va_list args;
    va_start(args, cnt);

    int arg;
    while (cnt--) {
        arg = va_arg(args, int);
    }
    va_end(args);
}
void kernel_init() {
    console_init();
    test_args(5, 1, 0xaa, 5, 0x55, 10);
}