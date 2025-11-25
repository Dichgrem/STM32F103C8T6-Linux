/* Linker script for STM32F103C8T6 */

ENTRY(Reset_Handler)

MEMORY
{
    FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 64K
    RAM (rwx)  : ORIGIN = 0x20000000, LENGTH = 20K
}

/* 栈顶地址 */
_estack = ORIGIN(RAM) + LENGTH(RAM);

SECTIONS
{
    /* 中断向量表和代码段 */
    .text :
    {
        KEEP(*(.isr_vector))    /* 中断向量表必须在最前面 */
        *(.text)                /* 代码 */
        *(.text*)
        *(.glue_7)              /* ARM/Thumb 互调用代码 */
        *(.glue_7t)
        *(.eh_frame)

        KEEP(*(.init))
        KEEP(*(.fini))

        . = ALIGN(4);
        _etext = .;             /* 代码段结束 */
    } > FLASH

    /* 只读数据段 */
    .rodata :
    {
        . = ALIGN(4);
        *(.rodata)
        *(.rodata*)
        . = ALIGN(4);
    } > FLASH

    /* ARM 异常展开信息（可选） */
    .ARM.extab :
    {
        *(.ARM.extab* .gnu.linkonce.armextab.*)
    } > FLASH

    .ARM :
    {
        *(.ARM.exidx*)
    } > FLASH

    /* 初始化数据的加载地址（在 FLASH 中） */
    _sidata = LOADADDR(.data);

    /* 已初始化数据段（运行时在 RAM，初始值在 FLASH） */
    .data :
    {
        . = ALIGN(4);
        _sdata = .;             /* 数据段开始 */
        *(.data)
        *(.data*)
        . = ALIGN(4);
        _edata = .;             /* 数据段结束 */
    } > RAM AT> FLASH

    /* 未初始化数据段（BSS） */
    .bss :
    {
        . = ALIGN(4);
        _sbss = .;              /* BSS 段开始 */
        __bss_start__ = _sbss;
        *(.bss)
        *(.bss*)
        *(COMMON)
        . = ALIGN(4);
        _ebss = .;              /* BSS 段结束 */
        __bss_end__ = _ebss;
    } > RAM

    /* 堆的起始位置（可选，malloc 使用） */
    ._user_heap_stack :
    {
        . = ALIGN(8);
        PROVIDE(end = .);
        PROVIDE(_end = .);
        PROVIDE(__end = .);
        . = . + 0x200;          /* 最小堆大小 512 字节 */
        . = . + 0x400;          /* 栈大小 1024 字节 */
        . = ALIGN(8);
    } > RAM

    /* 移除调试信息 */
    /DISCARD/ :
    {
        libc.a(*)
        libm.a(*)
        libgcc.a(*)
        *(.comment)
        *(.note)
        *(.note.*)
    }
}

/* 提供一些有用的符号供程序使用 */
PROVIDE(_stack = _estack);
PROVIDE(_data_start = _sdata);
PROVIDE(_data_end = _edata);
PROVIDE(_bss_start = _sbss);
PROVIDE(_bss_end = _ebss);
