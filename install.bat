if not exist arm-gnu-toolchain-13.2.rel1-mingw-w64-i686-arm-none-eabi.zip\arm-gnu-toolchain-13.2.Rel1-mingw-w64-i686-arm-none-eabi\bin\arm-none-eabi-gcc.exe (
   if not exist arm-gnu-toolchain-13.2.rel1-mingw-w64-i686-arm-none-eabi.zip (
      powershell -Command "Invoke-WebRequest https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-mingw-w64-i686-arm-none-eabi.zip -OutFile arm-gnu-toolchain-13.2.rel1-mingw-w64-i686-arm-none-eabi.zip"
      if exist arm-gnu-toolchain-13.2.rel1-mingw-w64-i686-arm-none-eabi.zip (
         powershell -Command "Expand-Archive arm-gnu-toolchain-13.2.rel1-mingw-w64-i686-arm-none-eabi.zip -DestinationPath ./"
      )
   ) else (
      powershell -Command "Expand-Archive arm-gnu-toolchain-13.2.rel1-mingw-w64-i686-arm-none-eabi.zip -DestinationPath ./"
   )
)

setx arm_gcc_compile_config "%cd%" /m
