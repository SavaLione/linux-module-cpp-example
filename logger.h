/*
 * Linux kernel logger for C and C++
 * Oleg Kutkov, 2019
 */

#ifndef LOGGER_H
#define LOGGER_H

#ifdef __cplusplus
extern "C" {
#endif
void kern_log(const char* fmt, ...);
#ifdef __cplusplus
}
#endif

#endif