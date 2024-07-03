set(__PROJECT_LIB_DIR
${CMAKE_CURRENT_SOURCE_DIR}/libs
)

set(__PROJECT_LIBS
)

# User modify area START

SET(TARGET_NAME demo_project)
SET(TARGET_VERSION_NUM 0.0.1)

SET(FLASH_BASE_ADDR
0x8000000
)
SET(FLASH_LENGTH
64K
)

set(__PROJECT_COMPILE_FLAG
    "-Og"
    "-Wall"
    "-g"
    "-gdwarf-2"
)

file(GLOB __PROJECT_SRC_FILES_ADD
code/third_party/freertos/*.c
)

set(__PROJECT_HEAD_DIRECTORIES
code/firmware/GD32F4xx_standard_peripheral/Include/
code/firmware/CMSIS/GD/GD32F4xx/Include/
code/firmware/CMSIS/
code/inc/bsp/
code/third_party/freertos/portable/GCC
code/third_party/freertos/include
code/inc/freertos
)

set(__PROJECT_SRC_FILES
${__PROJECT_SRC_FILES_ADD}
code/firmware/GD32F4xx_standard_peripheral/Source/gd32f4xx_rcu.c
code/firmware/GD32F4xx_standard_peripheral/Source/gd32f4xx_gpio.c
code/firmware/GD32F4xx_standard_peripheral/Source/gd32f4xx_usart.c
code/src/application/main.c
code/firmware/CMSIS/GD/GD32F4xx/Source/system_gd32f4xx.c
code/src/bsp/bsp_uart.c
code/third_party/freertos/portable/MemMang/heap_4.c
code/third_party/freertos/portable/GCC/port.c
)

# This variable __PROJECT_OB_DIR must be set as full path,
# please use the ${CMAKE_CURRENT_SOURCE_DIR} as the prefix
# If not use the function of adding binary then please comment this variable

# set(__PROJECT_OB_DIR
# ${CMAKE_CURRENT_SOURCE_DIR}/code/binary_file
# )

# User modify area END


