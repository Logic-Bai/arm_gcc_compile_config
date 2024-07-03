add_definitions(
    -DUSE_STDPERIPH_DRIVER
    -D__TARGET_FPU_VFP
    -DGD32F470
)
SET(RAM_BASE_ADDR
    0x20000000
)
SET(RAM_LENGTH
    448K
)
SET(TCMRAM_BASE_ADDR
    0x10000000
)
SET(TCMRAM_LENGTH
    64K
)

SET(TARGET_DEVICE_SVD
    ${CMAKE_CURRENT_LIST_DIR}/gd32/gd32f4/GD32F4xx.svd
)

SET(TARGET_DEVICE_COMPILE_OPT
    "-mcpu=cortex-m4"
    "-mthumb"
    "-mfpu=fpv4-sp-d16"
    "-mfloat-abi=hard"
)

SET(TARGET_DEVICE_STARTUP_FILE
    ${CMAKE_CURRENT_LIST_DIR}/gd32/gd32f4/gd32f470/startup_gd32f450_470.S
)

include(target_device)
