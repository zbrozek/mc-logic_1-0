#!/bin/bash

# Project name for binaries
PROJ="mc-logic"

# Architecture flags
TARGET+="-mlittle-endian -mcpu=cortex-m4 -march=armv7e-m -mthumb "
TARGET+="-mfpu=fpv4-sp-d16 -mfloat-abi=hard"

# Compiler option flags
COMPILEFLAGS+="-v -Wall -g -Os -fwrapv -fno-strict-aliasing "
COMPILEFLAGS+="-ffunction-sections -fdata-sections "

CFLAGS="$COMPILEFLAGS -std=gnu99"
CXXFLAGS="$COMPILEFLAGS -std=gnu++11"

# Search path flags
INC+="-I . "
INC+="-I stm32l4xx_cmsis "
INC+="-I stm32l4xx_hal "
INC+="-I stm32l4xx_usb_device "
INC+="-I freertos "

# Symbol definitions
SYM+="-D STM32L476xx "
SYM+="-D HSE_VALUE=16000000 "

# Linker options
#LDFLAGS+="-Tstm32_flash.ld -Wl,-Map=./bin/$PROJ.map "
LDFLAGS+="-Tstm32_flash.ld -Wl,--gc-sections -Wl,-Map=./bin/$PROJ.map "
LDFLAGS+="-Wl,--print-memory-usage "

# GNU ARM embedded toolchain executables
CC="arm-none-eabi-gcc"
CXX="arm-none-eabi-g++"
LD="arm-none-eabi-ld"
AR="arm-none-eabi-ar"
AS="arm-none-eabi-as"
OBJCOPY="arm-none-eabi-objcopy"
OBJDUMP="arm-none-eabi-objdump"
NM="arm-none-eabi-nm"
SIZE="arm-none-eabi-size"

# Find source files
#C+=$(find -L . -name '*.c')
#CPP+=$(find -L . -name '*.cpp')
#ASM+=$(find -L . -name '*.s')

# Libraries
#SRCS+="$(find -L ./stm32l4xx_hal -name '*.[c\|cpp]') "
#SRCS+="./stm32l4xx_usb_device/usbd_core.c "
#SRCS+="./stm32l4xx_usb_device/usbd_cdc.c "
#SRCS+="./stm32l4xx_usb_device/usbd_ctlreq.c "
#SRCS+="./stm32l4xx_usb_device/usbd_ioreq.c " 

# Other code
#SRCS+="$(find -L . -maxdepth 1 -name '*.[c\|cpp]') "
SRCS+="./main.c ./stm32l4xx_it.c ./system_stm32l4xx.c "
SRCS+="./startup_stm32l476xx.s "

mkdir -p bin
#$CC $TARGET $CFLAGS $LDFLAGS $INC $SYM $SRCS -o ./bin/$PROJ.elf
$CXX $TARGET $CXXFLAGS $LDFLAGS $INC $SYM $SRCS -o ./bin/$PROJ.elf
#$OBJCOPY -O ihex ./bin/$PROJ.elf ./bin/$PROJ.hex
#$OBJCOPY -O binary ./bin/$PROJ.elf ./bin/$PROJ.bin
#$SIZE -A -t ./bin/$PROJ.elf
