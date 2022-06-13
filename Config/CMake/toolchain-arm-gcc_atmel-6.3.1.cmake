#
# Toolchain binaries
#
set(TOOLCHAIN_BIN ${ARDUINO_TOOLCHAIN_DIR}/arm-none-eabi_atmel-6.3.1/bin)
set(CMAKE_C_COMPILER ${TOOLCHAIN_BIN}/arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_BIN}/arm-none-eabi-g++)
set(CMAKE_ASM_COMPILER ${TOOLCHAIN_BIN}/arm-none-eabi-gcc)
set(CMAKE_AR ${TOOLCHAIN_BIN}/arm-none-eabi-ar)
set(CMAKE_OBJCOPY ${TOOLCHAIN_BIN}/arm-none-eabi-objcopy)
set(CMAKE_OBJDUMP ${TOOLCHAIN_BIN}/arm-none-eabi-objdump)
set(SIZE ${TOOLCHAIN_BIN}/arm-none-eabi-size)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(CMAKE_C_OUTPUT_EXTENSION ".o")
set(CMAKE_C_OUTPUT_EXTENSION_REPLACE 1)
set(CMAKE_CXX_OUTPUT_EXTENSION ".o")
set(CMAKE_CXX_OUTPUT_EXTENSION_REPLACE 1)
set(CMAKE_ASM_OUTPUT_EXTENSION ".o")
set(CMAKE_ASM_OUTPUT_EXTENSION_REPLACE 1)
