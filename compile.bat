@echo off

if not exist "bin" (
    mkdir bin
)

echo generating the yaml file...
python generate_openapi.py
echo file generated!
echo.

if exist "openapi.yaml" (
    move .\openapi.yaml .\static\openapi.yaml
)

echo compiling cpp files...
setlocal enabledelayedexpansion

:: Get the directory where this script is located
set "SCRIPT_DIR=%~dp0"
:: Remove trailing backslash
set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"

:: Setup Visual Studio environment (adjust path as needed)
call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat" x64

set "SOURCES="
for /r %%f in (*.cpp) do (
    set "skip=0"
    
    :: Check exclusion patterns
    if "%%~nxf"=="test.cpp" set skip=1
    if "%%~nxf"=="test.cpp" if "%%~pf"==".\" set skip=1
    echo %%~pf | findstr /i /c:"\tests\" >nul && set skip=1
    echo %%~pf | findstr /i /c:"\fuzz\" >nul && set skip=1
    echo %%~pf | findstr /i /c:"\examples\" >nul && set skip=1
    echo %%~pf | findstr /i /c:"\test\" >nul && set skip=1
    echo %%~pf | findstr /i /c:"\mail++\" >nul && set skip=1
    echo %%~pf | findstr /i /c:"\CMakeFiles\" >nul && set skip=1
    echo %%~nf | findstr /i /c:"CMakeCXXCompilerId" >nul && set skip=1
    echo %%~nf | findstr /i /c:"vcpkg" >nul && set skip=1
    
    if !skip!==0 (
        set "SOURCES=!SOURCES! "%%f""
    )
)

:: Remove trailing space
if defined SOURCES set "SOURCES=!SOURCES:~1!"

:: MSVC compilation command
cl.exe /nologo /std:c++latest /EHsc /DWINDOWS /I "%SCRIPT_DIR%\vcpkg\installed\x64-windows\include" !SOURCES! /Fe:.\bin\server.exe /link sqlite3.lib libcrypto.lib libssl.lib ws2_32.lib mswsock.lib

if %errorlevel%==0 (
    echo compilation done!
) else (
    echo compilation failed with error %errorlevel%
)

endlocal