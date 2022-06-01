#include "../include/console.h"
#include "../include/string.h"

void console_init();
void console_clear();
void console_write(char *buf, int count);

#define CRT_ADDR 0x3D4
#define CRT_DATA 0x3D5

#define CURSOR_HIGH 0xE
#define CURSOR_LOW 0xF

#define SCREEN_HIGH 0xC
#define SCREEN_LOW 0xD

#define MEM_BASE 0XB8000
#define MEM_SIZE 0X7FFF
#define MEM_END (MEM_BASE + MEM_SIZE)

#define SCREEN_WIDTH 80
#define SCREEN_HEIGHT 25
#define SCREEN_ALL (SCREEN_WIDTH * SCREEN_HEIGHT)

static u16 erraser = 0x0020;

static u32 pos;
static u32 screen;
static void get_cursor() {
    outb(CRT_ADDR, CURSOR_HIGH);
    pos = inb(CRT_DATA) << 8;
    outb(CRT_ADDR, CURSOR_LOW);
    pos |= inb(CRT_DATA);

    pos <<= 1;
    pos += MEM_BASE;
}

static void set_cursor() {
    outb(CRT_ADDR, CURSOR_HIGH);
    outb(CRT_DATA, (pos - MEM_BASE) >> 9);
    outb(CRT_ADDR, CURSOR_LOW);
    outb(CRT_DATA, (pos - MEM_BASE) >> 1);
}

static void get_screen() {
    outb(CRT_ADDR, CURSOR_HIGH);
    screen = inb(CRT_DATA) << 8;
    outb(CRT_ADDR, SCREEN_LOW);
    screen |= inb(CRT_DATA);

    screen <<= 1;
    screen += MEM_BASE;
}
static void set_screen() {
    outb(CRT_ADDR, SCREEN_HIGH);
    outb(CRT_DATA, (screen - MEM_BASE) >> 9);
    outb(CRT_ADDR, SCREEN_LOW);
    outb(CRT_DATA, (screen - MEM_BASE) >> 1);
}
static void scroll() {
    get_screen();
    if (screen > MEM_END) {
        memcpy((void *)MEM_BASE, (const void *)screen, SCREEN_ALL);
        
    }
}
void console_clear() {
}
void console_init() {
    get_cursor();
    *(u16 *)0xb8000 = 0x0020;
    // *(u16 *)pos = 0xa462;
}