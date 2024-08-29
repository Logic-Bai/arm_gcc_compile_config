SET (TARGET_DEVICE_COMMON_COMPILE_OPT
    "-fdata-sections"
    "-ffunction-sections"
    "-specs=nano.specs"
)

enable_language(ASM)

set(ASM_COMPILE_OPTION
    -x
    assembler-with-cpp
)

add_library(target_device_asm STATIC
    ${ASM_FILES}
)

include_directories(target_device_asm
    ${PROJECT_BINARY_DIR}
    ${__PROJECT_HEAD_DIRECTORIES}
)

target_compile_options(target_device_asm PRIVATE
    ${ASM_COMPILE_OPTION}
    ${TARGET_DEVICE_COMMON_COMPILE_OPT}
    ${TARGET_DEVICE_COMPILE_OPT}
    "-Og"
    "-Wall"
    "-g"
    "-gdwarf-2"
)

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
