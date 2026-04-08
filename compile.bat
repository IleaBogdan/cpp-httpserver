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
    
    if !skip!==0 (
        set "SOURCES=!SOURCES! "%%f""
    )
)

:: Remove trailing space
if defined SOURCES set "SOURCES=!SOURCES:~1!"

g++ -std=c++23 -I"C:\Program Files\Crow 1.3.1\include" -DWINDOWS -pthread -Wall -Wextra !SOURCES! -o .\bin\server -lsqlite3 -lssl -lcrypto -lws2_32 -lmswsock

if %errorlevel%==0 (
    echo compilation done!
) else (
    echo compilation failed with error %errorlevel%
)

endlocal