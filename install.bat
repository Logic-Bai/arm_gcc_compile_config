cd /d %~dp0

if not exist arm-gnu-toolchain-13.2.Rel1-mingw-w64-i686-arm-none-eabi\bin\arm-none-eabi-gcc.exe (
   if not exist arm-gnu-toolchain-13.2.rel1-mingw-w64-i686-arm-none-eabi.zip (
      powershell -Command "Invoke-WebRequest https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-mingw-w64-i686-arm-none-eabi.zip -OutFile arm-gnu-toolchain-13.2.rel1-mingw-w64-i686-arm-none-eabi.zip"
      if exist arm-gnu-toolchain-13.2.rel1-mingw-w64-i686-arm-none-eabi.zip (
         powershell -Command "Expand-Archive arm-gnu-toolchain-13.2.rel1-mingw-w64-i686-arm-none-eabi.zip -DestinationPath ./"
      )
   ) else (
      powershell -Command "Expand-Archive arm-gnu-toolchain-13.2.rel1-mingw-w64-i686-arm-none-eabi.zip -DestinationPath ./"
   )
)

set arm_gcc_compile_config_path="%cd%"

echo %arm_gcc_compile_config_path%

setx /m arm_gcc_compile_config %arm_gcc_compile_config_path%

powershell -NoProfile -ExecutionPolicy Bypass -File "arm_gcc_compile_config_required_tools\add_make.ps1"

pause
