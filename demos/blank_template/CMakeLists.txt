cmake_minimum_required(VERSION 3.29)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/project_config")
include(source_file_config)

set(TOOLCHAIN arm-none-eabi)
set(TOOLCHAIN_EXT ".exe" )
set(TOOLCHAIN_PREFIX "$ENV{arm_gcc_compile_config}/arm-gnu-toolchain-13.2.Rel1-mingw-w64-i686-arm-none-eabi")
set(TOOLCHAIN_BIN_DIR ${TOOLCHAIN_PREFIX}/bin)
set(CMAKE_C_COMPILER ${TOOLCHAIN_BIN_DIR}/${TOOLCHAIN}-gcc${TOOLCHAIN_EXT} CACHE INTERNAL "C Compiler")
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_BIN_DIR}/${TOOLCHAIN}-g++${TOOLCHAIN_EXT} CACHE INTERNAL "C++ Compiler")
set(CMAKE_ASM_COMPILER ${TOOLCHAIN_BIN_DIR}/${TOOLCHAIN}-gcc${TOOLCHAIN_EXT} CACHE INTERNAL "ASM Compiler")

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)
SET(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED True)

project(${TARGET_NAME} VERSION ${TARGET_VERSION_NUM})

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/project_config/${TARGET_NAME}.h.in ${TARGET_NAME}.h)

include_directories(${TARGET_NAME}
    ${PROJECT_BINARY_DIR}
    ${__PROJECT_HEAD_DIRECTORIES}
)

list(APPEND CMAKE_MODULE_PATH "$ENV{arm_gcc_compile_config}/mcu_targets")
list(APPEND CMAKE_MODULE_PATH "$ENV{arm_gcc_compile_config}/linker")
list(APPEND CMAKE_MODULE_PATH "$ENV{arm_gcc_compile_config}/vscode_config")
include(${TARGET_DEVICE} RESULT_VARIABLE TARGET_DEVICE_FOUND)
if(${TARGET_DEVICE_FOUND} STREQUAL "NOTFOUND")
    include(error_msg)
endif()
include(linker)

set(__project_compile_option
    ${TARGET_DEVICE_COMPILE_OPT}
    ${TARGET_DEVICE_COMMON_COMPILE_OPT}
    ${__PROJECT_COMPILE_FLAG}
)

add_link_options(
    ${TARGET_DEVICE_COMPILE_OPT}
    ${TARGET_DEVICE_LINKER_OPT}
    "-specs=nano.specs"
    "-T${CMAKE_BINARY_DIR}/linker/linker.ld"
    "-Wl,-Map=output.map,--cref"
    "-Wl,--gc-sections"
    ${__PROJECT_LIBS}
)

if (DEFINED __PROJECT_OB_DIR)
    set (BINARY_FILE_OBJ
    ${CMAKE_BINARY_DIR}/binary_file.o
    )

    file(GLOB _t_PROJECT_OB_FILES
    ${__PROJECT_OB_DIR}/*
    )

    FOREACH(loop_var ${_t_PROJECT_OB_FILES})
        set(path ${loop_var})
        cmake_path(GET path FILENAME filename)
        list(APPEND __PROJECT_OB_FILES ${filename})
    ENDFOREACH(loop_var)

    add_custom_command(
        OUTPUT ${BINARY_FILE_OBJ}
        COMMAND ${TOOLCHAIN_BIN_DIR}/${TOOLCHAIN}-ld
        ARGS -r -b binary -o ${BINARY_FILE_OBJ} ${__PROJECT_OB_FILES}
        WORKING_DIRECTORY ${__PROJECT_OB_DIR}
        VERBATIM
    )
endif()

set(EXECUTABLE ${TARGET_NAME}.elf CACHE INTERNAL "TARGET")
add_executable(${EXECUTABLE} ${__PROJECT_SRC_FILES} ${BINARY_FILE_OBJ})
target_compile_options(${EXECUTABLE} PRIVATE ${__project_compile_option})

target_link_libraries(${EXECUTABLE}
target_device_startup
)

set (commands_create_output
COMMAND arm-none-eabi-strip     ARGS    ${EXECUTABLE} -s -o ${TARGET_NAME}_release.elf
COMMAND arm-none-eabi-objcopy   ARGS    -O binary ${TARGET_NAME}_release.elf ${TARGET_NAME}.bin
)

if (EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/tools/pad_byte.exe AND EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/tools/merge_hex.exe)
list(APPEND commands_create_output
COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/tools/pad_byte.exe  ARGS -f ${CMAKE_CURRENT_SOURCE_DIR}/tools/boot_image.bin -ts 0x10000 -b 0xff -o ${CMAKE_BINARY_DIR}/boot_image_temp.bin
COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/tools/merge_hex.exe ARGS -m ${CMAKE_BINARY_DIR}/boot_image_temp.bin ${TARGET_NAME}.bin -o ${CMAKE_BINARY_DIR}/russound_smz_mcu.bin
)
endif()

add_custom_command(
    TARGET ${EXECUTABLE}
    POST_BUILD
    ${commands_create_output}
)

include(vscode_config)
