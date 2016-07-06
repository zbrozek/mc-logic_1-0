# Reference: https://github.com/istarc/stm32/blob/master/examples/OOP/Makefile

# Binaries will be generated with this name (.elf, .bin, .hex, etc)
PROJ_NAME=mc-logic

# Put your STM32F4 library code directory here
STM_COMMON=../third_party/STM32Cube_FW_L4_V1.4.0

# GNU ARM Embedded Toolchain
CC=arm-none-eabi-gcc
CXX=arm-none-eabi-g++
LD=arm-none-eabi-ld
AR=arm-none-eabi-ar
AS=arm-none-eabi-as
CP=arm-none-eabi-objcopy
OD=arm-none-eabi-objdump
NM=arm-none-eabi-nm
SIZE=arm-none-eabi-size

# Find source files
ASOURCES=$(shell find -L $(SRCDIR) -name '*.s')
CSOURCES+=$(shell find -L $(SRCDIR) -name '*.c')
CXXSOURCES+=$(shell find -L $(SRCDIR) -name '*.cpp')

# Define output files
BINDIR=bin
BINELF=$(PROJ_NAME).elf
BINHEX=$(PROJ_NAME).hex
BINBIN=$(PROJ_NAME).bin

# Create object list
OBJECTS=$(ASOURCES:%.s=%.o)
OBJECTS+=$(CSOURCES:%.c=%.o)
OBJECTS+=$(CXXSOURCES:%.cpp=%.o)

CFLAGS  = -g -Os -Wall -Tstm32_flash.ld 
CFLAGS += -fstrict-aliasing
CFLAGS += -mlittle-endian -mthumb -mcpu=cortex-m4 -mthumb-interwork
CFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16
CFLAGS += -I.

# Project-level definitions
CFLAGS += -DSTM32L476xx

# Include files from STM libraries
CFLAGS += -I$(STM_COMMON)/Drivers/CMSIS/Include -I$(STM_COMMON)/Drivers/CMSIS/Device/ST/STM32L4xx/Include
CFLAGS += -I$(STM_COMMON)/Drivers/STM32L4xx_HAL_Driver/Inc

# add startup file to build
SRCS += $(STM_COMMON)/Drivers/CMSIS/Device/ST/STM32L4xx/Source/Templates/gcc/startup_stm32l476xx.s 
OBJS = $(SRCS:.c=.o)


.PHONY: proj

all: proj

proj: $(BINDIR)/$(BINELF)

$(BINDIR)/$(BINHEX): $(BINDIR)/$(BINELF)
	$(CP) -O ihex $< $@
	@echo "Objcopy from ELF to IHEX complete!\n"

$(BINDIR)/$(BINELF): $(OBJECTS)
	$(CXX) $(LDFLAGS) $(OBJECTS) -o $@
	@echo "Linking complete!\n"
	$(SIZE) $(BINDIR)/$(BINELF)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) $< -o $@
	@echo "Compiled "$<"!\n"

%.o: %.c
	$(CC) $(CFLAGS) $< -o $@
	@echo "Compiled "$<"!\n"

%.o: %.s
	$(CC) $(CFLAGS) $< -o $@
	@echo "Assambled "$<"!\n"

clean:
	rm -f $(OBJECTS) $(BINDIR)/$(BINELF) $(BINDIR)/$(BINHEX)

# Flash the STM32
burn: proj
	st-flash write $(PROJ_NAME).bin 0x8000000
