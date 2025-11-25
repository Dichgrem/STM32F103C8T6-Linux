# STM32F103C8T6-Linux

> This repo is the Jiangke STM32 Tutorial material in BiliBili

> Add Linux complie support , enable scons by add stm32f103c8.ld，SConstruct，syscalls.c，startup_wrapper.S , no need to install keil mdk.

<p align="center">
  <img src="https://github.com/Dichgrem/STM32F103C8T6-Linux/blob/main/devices.png" width="300">
</p>

## How to use

- Setup environment

```
## Ubuntu
sudo apt update
sudo apt install -y git python3 scons openocd stlink-tools gcc-arm-none-eabi gdb-multiarch

## Nixos
git clone https://github.com/Dichgrem/STM32F103C8T6-Linux.git
cd STM32F103C8T6-Linux && nix develop
```
- Clone this repo

```
git clone https://github.com/Dichgrem/STM32F103C8T6-Linux.git
cd STM32F103C8T6-Linux/Sourcecode
```

- Check stlink connect

```
❯ st-info --probe
Found 1 stlink programmers
  version:    V2J37S7
  serial:     37FF71064E57343603281543
  flash:      65536 (pagesize: 1024)
  sram:       20480
  chipid:     0x410
  2025-11-25T16:07:54dev-type:   STM32F1xx_MD
```

- Use scons to complie
```
❯ scons
scons: Reading SConscript files ...
scons: done reading SConscript files.
scons: Building targets ...
arm-none-eabi-gcc -o User/main.o -c -mcpu=cortex-m3 -mthumb -Wall -O2 -ffunction-sections -fdata-sections -DUSE_STDPERIPH_DRIVER -DSTM32F10X_MD -IUse
r -IStart -ILibrary -ISystem -IHardware User/main.c
arm-none-eabi-gcc -o User/stm32f10x_it.o -c -mcpu=cortex-m3 -mthumb -Wall -O2 -ffunction-sections -fdata-sections -DUSE_STDPERIPH_DRIVER -DSTM32F10X_
......
scons: `firmware.elf' is up to date.
scons: `firmware.bin' is up to date.
scons: `firmware.hex' is up to date.
scons: done building targets.

❯ ls
firmware.bin  firmware.hex  keilkill.bat  Listings  Project.uvguix.Admin  Project.uvprojx  Start           System
firmware.elf  firmware.map  Library       Objects   Project.uvoptx        SConstruct       stm32f103c8.ld  User
```

- Use st-flash to write

```
❯ st-flash write firmware.bin 0x08000000
st-flash 1.8.0
INFO common.c: STM32F1xx_MD: 20 KiB SRAM, 64 KiB flash in at least 1 KiB pages.
file firmware.bin md5 checksum: cb4d34581a6548bd9c6ee386e94bb5, stlink checksum: 0x00015d0a
INFO common_flash.c: Attempting to write 1152 (0x480) bytes to stm32 address: 134217728 (0x8000000)
-> Flash page at 0x8000400 erased (size: 0x400)
INFO flash_loader.c: Starting Flash write for VL/F0/F3/F1_XL
INFO flash_loader.c: Successfully loaded flash loader in sram
INFO flash_loader.c: Clear DFSR
  2/2   pages written
INFO common_flash.c: Starting verification of write complete
INFO common_flash.c: Flash written and verified! jolly good!
```

## Directory Structure
```
STM32F103C8T6-Linux main
❯ tree -L 2 -v
.
├── Document
│   ├── 0-参考文档
│   ├── 1-STM32F103C8T6核心板
│   ├── 2-STLINK下载器
│   ├── 3-有源蜂鸣器
│   ├── 4-光敏电阻传感器
│   ├── 5-热敏电阻传感器
│   ├── 6-反射式红外传感器
│   ├── 7-对射式红外传感器
│   ├── 8-OLED显示屏
│   ├── 9-TB6612电机驱动
│   ├── 10-SG90舵机
│   ├── 11-旋转编码器
│   ├── 12-CH340 USB转串口
│   ├── 13-MPU6050 陀螺仪加速度计
│   ├── 14-W25QXX Flash闪存
│   └── STM32入门教程.pptx
├── LICENSE
├── Library
│   └── STM32F10x_StdPeriph_Lib_V3.5.0
├── README.md
├── Sourcecode
│   ├── 1-1-接线图
│   ├── 1-2-keilkill批处理
│   ├── 1-3-Delay函数模块
│   ├── 1-4-OLED驱动函数模块
│   ├── 2-1-STM32工程模板
│   ├── 3-1-LED闪烁
│   ├── 3-2-LED流水灯
│   ├── 3-3-蜂鸣器
│   ├── 3-4-按键控制LED
│   ├── 3-5-光敏传感器控制蜂鸣器
│   ├── 4-1-OLED显示屏
│   ├── 5-1-对射式红外传感器计次
│   ├── 5-2-旋转编码器计次
│   ├── 6-1-定时器定时中断
│   ├── 6-2-定时器外部时钟
│   ├── 6-3-PWM驱动LED呼吸灯
│   ├── 6-4-PWM驱动舵机
│   ├── 6-5-PWM驱动直流电机
│   ├── 6-6-输入捕获模式测频率
│   ├── 6-7-PWMI模式测频率占空比
│   ├── 6-8-编码器接口测速
│   ├── 7-1-AD单通道
│   ├── 7-2-AD多通道
│   ├── 8-1-DMA数据转运
│   ├── 8-2-DMA+AD多通道
│   ├── 9-1-串口发送
│   ├── 9-2-串口发送+接收
│   ├── 9-3-串口收发HEX数据包
│   ├── 9-4-串口收发文本数据包
│   ├── 10-1-软件I2C读写MPU6050
│   ├── 10-2-硬件I2C读写MPU6050
│   ├── 11-1-软件SPI读写W25Q64
│   ├── 11-2-硬件SPI读写W25Q64
│   ├── 12-1-读写备份寄存器
│   ├── 12-2-实时时钟
│   ├── 13-1-修改主频
│   ├── 13-2-睡眠模式+串口发送+接收
│   ├── 13-3-停止模式+对射式红外传感器计次
│   ├── 13-4-待机模式+实时时钟
│   ├── 14-1-独立看门狗
│   ├── 14-2-窗口看门狗
│   ├── 15-1-读写内部FLASH
│   └── 15-2读取芯片ID
├── flake.lock
└── flake.nix
63 directories, 5 files
```

## Acknowledgements

- [江协科技-STM32入门教程](https://www.bilibili.com/video/BV1th411z7sn/)
- [原版资料下载](https://jiangxiekeji.com/index.html)
- [trebisky/stm32f103](https://github.com/trebisky/stm32f103)
- [getoffmyhack/STM32F103-Bare-Metal](https://github.com/getoffmyhack/STM32F103-Bare-Metal)
- [KrIsKa7a/STM32-MCU-BareMetalDemoCode](https://github.com/KrIsKa7a/STM32-MCU-BareMetalDemoCode)
- [mensi/stm32_bare_metal](https://github.com/mensi/stm32_bare_metal)
- [ve3wwg/stm32f103c8t6](https://github.com/ve3wwg/stm32f103c8t6)
