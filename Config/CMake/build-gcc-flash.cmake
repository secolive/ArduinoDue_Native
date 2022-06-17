set(MAP_FILE ${PROJECT_OUTPUT_DIR}/${PROJECT_NAME}.map)
set(HEX_FILE ${PROJECT_OUTPUT_DIR}/${PROJECT_NAME}.hex)
set(BIN_FILE ${PROJECT_OUTPUT_DIR}/${PROJECT_NAME}.bin)


function(buildAsFlashImage target)
  set_target_properties(${target} PROPERTIES SUFFIX ".elf")
  target_link_options(${target} PRIVATE -static)
  target_link_options(${target} PRIVATE -Wl,--cref -Wl,--print-memory-usage,-Map=${MAP_FILE})
  target_link_options(${target} PRIVATE -T${LINKER_SCRIPT})
endfunction()

function(generateHexFiles target)
  add_custom_command(TARGET ${target} POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} -Oihex $<TARGET_FILE:${PROJECT_NAME}.elf> ${HEX_FILE}
        COMMAND ${CMAKE_OBJCOPY} -Obinary $<TARGET_FILE:${PROJECT_NAME}.elf> ${BIN_FILE}
        COMMENT "Building ${HEX_FILE}
Building ${BIN_FILE}")
endfunction()
