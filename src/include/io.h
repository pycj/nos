#ifndef NOS_IO_H
#define NOS_IO_H
#include "types.h"

void outb(u16 port, u8 data);
void outw(u16 port, u16 data);

u8 inb(u16 port);
u16 inw(u16 port);

#endif