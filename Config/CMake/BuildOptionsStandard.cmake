if(NOT DEFINED ARDUINO_BUILD_FOR_HOST)
  #Uncomment for hardware floating point
  #add_compile_definitions(ARM_MATH_CM4;ARM_MATH_MATRIX_CHECK;ARM_MATH_ROUNDING)
  #add_compile_options(-mfloat-abi=hard -mfpu=fpv4-sp-d16)
  #add_link_options(-mfloat-abi=hard -mfpu=fpv4-sp-d16)

  #Uncomment for software floating point
  add_compile_options(-mfloat-abi=soft)

  # uncomment to mitigate c++17 absolute addresses warnings
  #set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-register")

  add_compile_options(--param max-inline-insns-single=500)
  add_compile_options(-fno-exceptions)

  # These apply only to C++
  add_compile_options($<$<COMPILE_LANGUAGE:CXX>:-fno-threadsafe-statics>)
  add_compile_options($<$<COMPILE_LANGUAGE:CXX>:-fno-rtti>)
endif ()
