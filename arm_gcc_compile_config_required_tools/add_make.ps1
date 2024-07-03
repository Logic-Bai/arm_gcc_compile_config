# add_make.ps1

$oldPath = [Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::Machine)

$currentPath = (Get-Location).ToString()

$pathEntries = $oldPath -split ';'
$newPathEntries = @()
$excludePath1 = '\arm_gcc_compile_config_required_tools'
$excludePath2 = '\arm-gnu-toolchain-13.2.Rel1-mingw-w64-i686-arm-none-eabi\bin'
foreach ($entry in $pathEntries) {
    if ($entry -notlike "*$excludePath1*" -and $entry -notlike "*$excludePath2*") {
        $newPathEntries += $entry
    }
}
$newPath = $newPathEntries -join ';'
$newPath = $newPath + ';' + $currentPath + $excludePath1 + ';' + $currentPath + $excludePath2
[Environment]::SetEnvironmentVariable('Path', $newPath, [System.EnvironmentVariableTarget]::Machine)
# Write-Output "The new PATH is: $newPath"

