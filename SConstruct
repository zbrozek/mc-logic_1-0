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

# Custom CPU architecture list that we reuse several times.
env.Append(CPU_FLAGS = [
  '-mthumb',
  '-mcpu=cortex-m4',
  '-mfpu=fpv4-sp-d16',
  '-mfloat-abi=hard',
  '-march=armv7e-m',
  '-mlittle-endian',
  ])

# Flags passed to the linker (note that it's g++).
env.Append(LINKFLAGS = [
  '$CPU_FLAGS',
  '-Tstm32_flash.ld',  # Specify the linker script.
  '-Wl,--gc-sections',  # Enable garbage collection to remove unused code.
  '-Wl,-X',  # Delete all temporary local symbols.
  '-Wl,--print-memory-usage',  # Get a memory usage summary post-linking.
  ])

# Flags passed to both C and C++ compilers.
env.Append(CCFLAGS = [
	'$CPU_FLAGS',
	'-Wall',  # Enable all warnings.
	'-g',  # Enable debug symbols.
  '-O2',  # Optimization level.
	'-fwrapv',  # Enable twos-complement integer overflow.
  '-fno-strict-aliasing',  # Disable strict aliasing optimizations.
	'-fsigned-char',  # char defaults to signed.
	'-ffunction-sections',  # Let the linker do placement optimization.
	'-fdata-sections',
  '-fno-exceptions',  # Remove support for exceptions.
	])

# Flags passed to just the C compiler.
env.Append(CFLAGS = [
	'-std=gnu11',  # 2011 C standard plus GNU extensions.
  ])

# Flags passed to just the C++ compiler.
env.Append(CXXFLAGS = [
  '-std=gnu++14'  # 2014 C++ standard plus GNU extensions.
  ])

# Symbol definitions.
env.Append(CPPDEFINES = [
  'STM32L476xx',  # ST peripheral library wants to know what CPU we have.
  'HSE_VALUE=16000000',  # Specify our external crystal frequency.
  '__CORTEX_M4',  # Used by ARM math libraries.
  '__FPU_PRESENT=1',  # Used by ARM math libraries.
  ])

# Include paths.
env['CPPPATH'] = [
	'#stm32l4xx_cmsis',
  '#stm32l4xx_hal',
  '#stm32l4xx_usb_device',
	]

# Program-specific information; the meaty bits.
elf = env.Program(
  target = 'mc-logic',
  source = [
    "main.c",
    "startup_stm32l476xx.s",
    "stm32l4xx_it.c",
    "system_stm32l4xx.c",
  ]
)

# Make hex and bin files for our flashing convenience.
hex = env.Command("mc-logic.hex",
                  elf,
                  "arm-none-eabi-objcopy -O ihex mc-logic.elf mc-logic.hex")
bin = env.Command("mc-logic.bin",
                  elf,
                  "arm-none-eabi-objcopy -O binary mc-logic.elf mc-logic.bin")
