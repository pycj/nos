#ifndef NOS_STDIO_H
#define NOS_STDIO_H

#include "../include/stdarg.h"

int vsprintf(char *buf, const char *fmt, va_list args);
int sprintf(char *buf, const char *fmt, ...);

#endif