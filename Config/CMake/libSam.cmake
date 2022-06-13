#
# Libraries definitions
#
include_directories(
    ${ARDUINO_CORE_SRC}/system/libsam/
    ${ARDUINO_CORE_SRC}/system/CMSIS/CMSIS/Include/
    ${ARDUINO_CORE_SRC}/system/CMSIS/Device/ATMEL/
    ${ARDUINO_CORE_SRC}/system/CMSIS/Device/ATMEL/sam3xa/include/
        )

add_library(sam_sam3x8e_gcc_rel STATIC IMPORTED)
set_target_properties(sam_sam3x8e_gcc_rel PROPERTIES IMPORTED_LOCATION ${ARDUINO_CORE_SRC}/variants/arduino_due_x/libsam_sam3x8e_gcc_rel.a)
set(ARDUINO_LIB_PLATFORM sam_sam3x8e_gcc_rel)

