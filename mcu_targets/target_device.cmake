SET (TARGET_DEVICE_COMMON_COMPILE_OPT
    "-fdata-sections"
    "-ffunction-sections"
    "-specs=nano.specs"
)

enable_language(ASM)

set(STARTUP_COMPILE_OPTION
    -x
    assembler-with-cpp
)

add_library(target_device_startup STATIC
    ${TARGET_DEVICE_STARTUP_FILE}
)

target_compile_options(target_device_startup PRIVATE
    ${STARTUP_COMPILE_OPTION}
    ${TARGET_DEVICE_COMMON_COMPILE_OPT}
    ${TARGET_DEVICE_COMPILE_OPT}
    "-Og"
    "-Wall"
    "-g"
    "-gdwarf-2"
)

# add_library(target_device_syscalls STATIC
#     ${CMAKE_CURRENT_LIST_DIR}/system/syscalls.c
# )

# target_compile_options(target_device_startup PRIVATE
#     ${TARGET_DEVICE_COMMON_COMPILE_OPT}
#     ${TARGET_DEVICE_COMPILE_OPT}
#     "-Og"
#     "-Wall"
#     "-g"
#     "-gdwarf-2"
# )

list(APPEND __PROJECT_SRC_FILES
    ${CMAKE_CURRENT_LIST_DIR}/system/syscalls.c
)

file(MAKE_DIRECTORY
    ${CMAKE_BINARY_DIR}/svd
)

file(COPY_FILE
    ${TARGET_DEVICE_SVD}
    ${CMAKE_BINARY_DIR}/svd/target_device.svd
)
