add_compile_options(-nostdlib)
add_link_options(-static)

set(HEX_FILE ${PROJECT_OUTPUT_DIR}/${PROJECT_NAME}.hex)
set(BIN_FILE ${PROJECT_OUTPUT_DIR}/${PROJECT_NAME}.bin)

add_link_options(-Wl,--cref -Wl,--print-memory-usage,-Map=${PROJECT_OUTPUT_DIR}/${PROJECT_NAME}.map)
add_link_options(-T${LINKER_SCRIPT})

function(generateHexFiles target)
  add_custom_command(TARGET ${target} POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} -Oihex $<TARGET_FILE:${PROJECT_NAME}.elf> ${HEX_FILE}
        COMMAND ${CMAKE_OBJCOPY} -Obinary $<TARGET_FILE:${PROJECT_NAME}.elf> ${BIN_FILE}
        COMMENT "Building ${HEX_FILE}
Building ${BIN_FILE}")
endfunction()
