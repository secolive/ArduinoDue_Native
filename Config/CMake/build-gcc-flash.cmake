function(setOptionsForFlashImage target)
  set(t "$<TARGET_FILE_DIR:${target}>/$<TARGET_FILE_PREFIX:${target}>$<TARGET_FILE_BASE_NAME:${target}>")

  target_link_options(${target} PRIVATE -static)
  target_link_options(${target} PRIVATE -Wl,--cref -Wl,--print-memory-usage,-Map=${t}.map)
  target_link_options(${target} PRIVATE -T${LINKER_SCRIPT})
endfunction()

function(generateHexFiles target)
  set(t "$<TARGET_FILE_DIR:${target}>/$<TARGET_FILE_PREFIX:${target}>$<TARGET_FILE_BASE_NAME:${target}>")

  add_custom_command(TARGET ${target} POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} -Oihex $<TARGET_FILE:${target}> "${t}.hex"
        COMMAND ${CMAKE_OBJCOPY} -Obinary $<TARGET_FILE:${target}> "${t}.bin"
        COMMENT "Building ${target}.hex
Building ${target}.bin")
endfunction()
