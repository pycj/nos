#ifndef NOS_STRING_H
#define NOS_STRING_H

#include "../include/types.h"
u8 *strcpy(u8 *dest, const u8 *src);
u8 *strcat(u8 *dest, const u8 *src);
size_t strlen(const u8 *str);
int strcmp(const u8 *lhs, const u8 *rhs);
u8 *strchr(const u8 *str, int ch);
u8 *strrchr(const u8 *str, int ch);

int memcmp(const void *lhs, const void *rhs, size_t count);
void *memset(void *dest, int ch, size_t count);
void *memcpy(void *dest, const void *src, size_t count);
void *memchr(const void *ptr, int ch, size_t count);
#endif
