#!python

proj = 'mc-logic'

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
  '-fdiagnostics-color=always',  # Color output
	])

# Flags passed to just the C compiler.
env.Append(CFLAGS = [
	'-std=gnu11',  # 2011 C standard plus GNU extensions.
  ])

# Flags passed to just the C++ compiler.
env.Append(CXXFLAGS = [
  '-std=gnu++14'  # 2014 C++ standard plus GNU extensions.
  ])

# Reduce the amount of garbage scrolling by.
if ARGUMENTS.get('VERBOSE') != '1':
	env['CCCOMSTR'] = "Compiling $TARGET"
	env['LINKCOMSTR'] = "Linking $TARGET"

# Import the main project child script.
VariantDir('bin', 'src', duplicate=0)
bins = SConscript(['bin/SConscript'], exports='env proj')

# Import the openocd child script.
SConscript(['extra/SConscript'], exports='env proj bins')
