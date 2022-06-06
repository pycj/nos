#ifndef NOS_TYPE_H
#define NOS_TYPE_H

#define EOF -1
#define EOS 0
#define NULL (void *)0
#define false 0
#define true 1
#define bool _Bool

#define _packed __attribute__((packed))

typedef unsigned int size_t;

typedef char int8;
typedef short int16;
typedef int int32;
typedef long long int64;

typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned int u32;
typedef unsigned long long u64;

#endif
