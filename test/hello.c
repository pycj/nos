// #include <stdio.h>

typedef char *va_list;

#define va_start(ap, v) (ap = (va_list)&v + sizeof(char *))
#define va_arg(ap, t) (*(t *)((ap += sizeof(char *)) - sizeof(char *)))
#define va_end(ap) (ap = (va_list)0)

void test_args(int cnt, ...) {
    va_list args;
    va_start(args, cnt);

    int arg;
    while (cnt--) {
        arg = va_arg(args, int);
    }
    va_end(args);
}
int main() {
    test_args(5, 1, 0xaa, 5, 0x55, 10);
}
