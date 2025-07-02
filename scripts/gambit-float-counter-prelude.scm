(c-declare #<<EOF
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>
#include <inttypes.h>

#undef ___F64BOX
#define ___F64BOX(x) ___MEM_ALLOCATED_FLONUM_ALLOC(__LOG__F64(x))

uint64_t exponent_count[2048] = {0};  // One slot per possible exponent (11-bit)
uint64_t zero_count = 0;
uint64_t inf_count = 0;
uint64_t nan_count = 0;

void print_binary11(uint16_t val) {
    for (int i = 10; i >= 0; i--) {
        putchar((val & (1 << i)) ? '1' : '0');
    }
}

void print_float_stats(void) {
    printf("=== float distribution ===\n");
    printf("zero,%" PRIu64 "\n", zero_count);
    printf("inf,%" PRIu64 "\n", inf_count);
    printf("nan,%" PRIu64 "\n", nan_count);

    for (int i = 0; i < 2048; i++) {
        if (exponent_count[i] > 0) {
            print_binary11(i);
            printf(",%" PRIu64 "\n", exponent_count[i]);
        }
    }
    printf("=== end float distribution ===\n");
}

___F64 __LOG__F64(___F64 val) {
    static int initialized = 0;
    if (!initialized) {
        atexit(print_float_stats);
        initialized = 1;
    }

    if (val == 0.0) {
        zero_count++;
    } else if (isnan(val)) {
        nan_count++;
    } else if (isinf(val)) {
        inf_count++;
    } else {
        uint64_t bits;
        memcpy(&bits, &val, sizeof(bits));
        uint16_t exponent = (bits >> 52) & 0x7FF;  // extract exponent bits
        exponent_count[exponent]++;
    }
    return val;
}
EOF
)