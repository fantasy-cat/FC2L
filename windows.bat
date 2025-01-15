@echo off
echo Welcome to FC2L @ Windows
echo Hit enter to begin

set BUILD_DIR=fc2l/windows
set SRC_DIR=luajit/src
set FC2_DIR=fc2t
set VS_ENV=

if not exist "%BUILD_DIR%" (
    mkdir "%BUILD_DIR%"
)

pause

for /f "usebackq delims=" %%i in (`vswhere.exe -prerelease -latest -property installationPath`) do (
    if exist "%%i\VC\Auxiliary\Build\vcvars64.bat" (
        set VS_ENV=%%i\VC\Auxiliary\Build\vcvars64.bat
    )
)

if not defined VS_ENV (
    echo Visual Studio Command Prompt environment not found.
    pause
    exit /b 1
)

echo Found Visual Studio environment: "%VS_ENV%"

cd "%SRC_DIR%"
call "%VS_ENV%"
call cmd /c "msvcbuild.bat static x64"

if not exist "lua51.lib" (
    echo Build failed.
    pause
    exit /b 1
)

cd ../../

echo Cleaning old build files in %BUILD_DIR%...

for /d %%d in ("%BUILD_DIR%\*") do (
    rmdir /s /q "%%d"
)

for %%f in ("%BUILD_DIR%\*") do (
    del /q "%%f"
)

echo Moving build files to %BUILD_DIR%...
xcopy /s "%SRC_DIR%\*.lib" "%BUILD_DIR%"
xcopy /s "%SRC_DIR%\*.dll" "%BUILD_DIR%"
xcopy /s "%SRC_DIR%\*.exp" "%BUILD_DIR%"
xcopy /s "%SRC_DIR%\*.exe" "%BUILD_DIR%"
xcopy /s "%SRC_DIR%\*.pdb" "%BUILD_DIR%"

echo Moving header files to %BUILD_DIR%...
xcopy /s "%SRC_DIR%\*.hpp" "%BUILD_DIR%" /EXCLUDE:xcopy.txt
xcopy /s "%SRC_DIR%\*.h" "%BUILD_DIR%" /EXCLUDE:xcopy.txt

echo Moving fc2 header files to %BUILD_DIR%...
xcopy /s "%FC2_DIR%\*.hpp" "%BUILD_DIR%" /EXCLUDE:xcopy.txt
xcopy /s "%FC2_DIR%\*.h" "%BUILD_DIR%" /EXCLUDE:xcopy.txt

echo Build and file organization complete!
echo Files are now located in %BUILD_DIR%.
pause
