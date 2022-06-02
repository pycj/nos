#ifndef NOS_CONSOLE_H
#define NOS_CONSOLE_H
#include "../include/types.h"
#include "../include/io.h"

void console_init();
void console_clear();
void console_write(u8 *buf, u32 count);

#endif