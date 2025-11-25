/**
 * @file syscalls.c
 * @brief 系统调用桩函数实现
 *
 * 为 newlib 提供最小的系统调用实现，避免链接错误
 */

#include <sys/stat.h>
#include <errno.h>

#undef errno
extern int errno;

/* 环境变量 */
char *__env[1] = { 0 };
char **environ = __env;

/* 退出程序 */
void _exit(int status) {
    (void)status;
    while (1) {
        /* 无限循环，嵌入式系统不应该退出 */
    }
}

/* 关闭文件 */
int _close(int file) {
    (void)file;
    return -1;
}

/* 执行程序 */
int _execve(char *name, char **argv, char **env) {
    (void)name;
    (void)argv;
    (void)env;
    errno = ENOMEM;
    return -1;
}

/* 创建子进程 */
int _fork(void) {
    errno = EAGAIN;
    return -1;
}

/* 获取文件状态 */
int _fstat(int file, struct stat *st) {
    (void)file;
    st->st_mode = S_IFCHR;
    return 0;
}

/* 获取进程 ID */
int _getpid(void) {
    return 1;
}

/* 检查文件是否为终端 */
int _isatty(int file) {
    (void)file;
    return 1;
}

/* 发送信号 */
int _kill(int pid, int sig) {
    (void)pid;
    (void)sig;
    errno = EINVAL;
    return -1;
}

/* 创建链接 */
int _link(char *old, char *new) {
    (void)old;
    (void)new;
    errno = EMLINK;
    return -1;
}

/* 文件定位 */
int _lseek(int file, int ptr, int dir) {
    (void)file;
    (void)ptr;
    (void)dir;
    return 0;
}

/* 打开文件 */
int _open(const char *name, int flags, int mode) {
    (void)name;
    (void)flags;
    (void)mode;
    return -1;
}

/* 读取文件 */
int _read(int file, char *ptr, int len) {
    (void)file;
    (void)ptr;
    (void)len;
    return 0;
}

/* 堆内存分配 */
extern char _end;              /* 由链接脚本定义 */
static char *heap_end = 0;

void *_sbrk(int incr) {
    char *prev_heap_end;

    if (heap_end == 0) {
        heap_end = &_end;
    }

    prev_heap_end = heap_end;
    heap_end += incr;

    return (void *)prev_heap_end;
}

/* 获取文件状态 */
int _stat(const char *file, struct stat *st) {
    (void)file;
    st->st_mode = S_IFCHR;
    return 0;
}

/* 获取系统时间 */
int _times(void *buf) {
    (void)buf;
    return -1;
}

/* 删除文件 */
int _unlink(char *name) {
    (void)name;
    errno = ENOENT;
    return -1;
}

/* 等待子进程 */
int _wait(int *status) {
    (void)status;
    errno = ECHILD;
    return -1;
}

/* 写入文件 */
int _write(int file, char *ptr, int len) {
    (void)file;
    (void)ptr;
    /* 对于嵌入式系统，可以将输出重定向到 UART */
    /* 这里简单返回写入的长度 */
    return len;
}
