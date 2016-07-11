#!python

import multiprocessing

SetOption('num_jobs', multiprocessing.cpu_count())

env = Environment()

env['AR'] = 'arm-none-eabi-ar'
env['AS'] = 'arm-none-eabi-as'
env['CC'] = 'arm-none-eabi-gcc'
env['CXX'] = 'arm-none-eabi-g++'
env['LINK'] = 'arm-none-eabi-g++'
env['RANLIB'] = 'arm-none-eabi-ranlib'
env['OBJCOPY'] = 'arm-none-eabi-objcopy'
env['OBJDUMP'] = 'arm-none-eabi-objdump'
env['PROGSUFFIX'] = '.elf'

env.Append(LINKFLAGS = [
  '-Tstm32_flash.ld',
  '-Wl,--gc-sections',
  '-Wl,-X',
  '-Wl,--print-memory-usage',
  ])

# Flags passed to both C and C++ compilers
env.Append(CCFLAGS = [
	'-mcpu=cortex-m4',
	'-mthumb',
  '-mlittle-endian',
#  '-march=armv7e-m',
#  '-mfpu=fpv4-sp-d16',
#  '-mfloat-abi=hard',
	'-Wall',
	'-g',
  '-O2',
	'-fwrapv',
  '-fno-strict-aliasing',
	'-fsigned-char',
	'-ffunction-sections',
	'-fdata-sections',
	])

# Flags passed to just the C compiler
env.Append(CFLAGS = [
	'-std=gnu11',
  ])

# Flags passed to just the C++ compiler
env.Append(CXXFLAGS = [
  '-std=gnu++14'
  ])

# Symbol definitions
env.Append(CPPDEFINES = [
  'STM32L476xx',
  'HSE_VALUE=16000000',
  ])

# Include paths
env['CPPPATH'] = [
	'#stm32l4xx_cmsis',
  '#stm32l4xx_hal',
  '#stm32l4xx_usb_device',
	]

env.Program(
  target = 'mc-logic',
  source = [
    "main.c",
    "startup_stm32l476xx.s",
    "stm32l4xx_it.c",
    "system_stm32l4xx.c",
  ]
)

