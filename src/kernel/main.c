#include "../include/nos.h"
#include "../include/types.h"
#include "../include/io.h"
#include "../include/string.h"
#include "../include/console.h"

u8 message[] = "Hello, world";
u8 buf[1024];
void kernel_init() {
    // int res;

    // strcpy(buf, message);
    // strcat(buf, message);
    // size_t len = strlen(buf);
    // res = strcmp(message, buf);
    // buf[8] = 'a';
    // res = strcmp(message, buf);
    // u8 *ptr = strchr(message, 'e');
    // ptr = strrchr(message, 'o');

    // res = memcmp(message, buf, 8);
    // buf[7] = 'a';
    // res = memcmp(message, buf, 8);
    // memset(buf, 't', 3);
    // memcpy(message, buf, 3);
    // ptr = memchr(message, 'o', 2);
    // strcpy(buf, message);

    // char*video = (char*)(0xb8000);
    // for (int i = 0; i < sizeof(message); i++)
    // {
    //     video[i * 2] = message[i];
    // }
    // while(1)
    // ;
    // outb(0x3d4, 0xe);

}