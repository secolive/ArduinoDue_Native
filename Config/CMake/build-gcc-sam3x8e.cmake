set(MCPU cortex-m3)
add_compile_options(-mcpu=${MCPU} -mthumb -mthumb-interwork)
add_link_options(-mcpu=${MCPU} -mthumb -mthumb-interwork)


set(ARDUINO_STARTUP_SOURCE ${ARDUINO_CORE_SRC}/system/CMSIS/Device/ATMEL/sam3xa/source/gcc_atmel/startup_sam3xa.c)
set(LINKER_SCRIPT_DIR ${ARDUINO_CORE_SRC}/system/CMSIS/Device/ATMEL/sam3xa/source/gcc_atmel/)
set(LINKER_SCRIPT sam3x8e_flash.ld)
add_link_options("-L${LINKER_SCRIPT_DIR}")
