#ifndef NOS_TASK_H
#define NOS_TASK_H

#include "../include/types.h"

typedef u32 target_t();

typedef struct {
    u32 *stack;

} task_t;

typedef struct {
    u32 edi;
    u32 esi;
    u32 ebx;
    u32 ebp;
    void (*eip)(void);
} task_frame_t;
void task_init();
#endif