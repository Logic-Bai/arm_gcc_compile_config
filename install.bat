ECHO OFF

cd /d %~dp0

set "url=https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-mingw-w64-i686-arm-none-eabi.zip"
set "download_file=arm-gnu-toolchain-13.2.rel1-mingw-w64-i686-arm-none-eabi.zip"
set "expected_file=arm-gnu-toolchain-13.2.Rel1-mingw-w64-i686-arm-none-eabi\bin\arm-none-eabi-gcc.exe"
set "expected_hash=51d933f00578aa28016c5e3c84f94403274ea7915539f8e56c13e2196437d18f"

if not exist %expected_file% (
   if not exist %download_file% (
      powershell -Command "Invoke-WebRequest %url% -OutFile %download_file%"
   )
) else (
   goto :register
)

if exist "%download_file%" (
    echo File downloaded successfully.
) else (
    echo File download failed.
    exit /b 1
)

for /f %%i in ('powershell -Command "Get-FileHash -Path '%download_file%' -Algorithm SHA256 | Select-Object -ExpandProperty Hash"') do set "calculated_hash=%%i"

if /i "%calculated_hash%"=="%expected_hash%" (
   echo The SHA-256 hash matches.
   powershell -Command "Expand-Archive '%download_file%' -DestinationPath ./"
   echo File extracted successfully.
   exit /b 0
) else (
   echo The SHA-256 hash does not match.

   del "%download_file%"
   echo File deleted due to hash mismatch.
   exit /b 1
)


:register
set arm_gcc_compile_config_path="%cd%"

echo %arm_gcc_compile_config_path%

setx /m arm_gcc_compile_config %arm_gcc_compile_config_path%

powershell -NoProfile -ExecutionPolicy Bypass -File "arm_gcc_compile_config_required_tools\add_make.ps1"

endlocal

pause
