/*
 * Linux kernel logger for C and C++
 * Oleg Kutkov, 2019
 */

#include <linux/kernel.h>
#include "logger.h"

void kern_log(const char* fmt, ...)
{
    va_list args;
    va_start(args, fmt);
    vprintk(fmt, args);
    va_end(args);
}