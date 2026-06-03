@echo off
setlocal

set "CDD_EXE=C:\cdd\cddx.exe"
set "CDD_LASTDIR=%TEMP%\cdd-lastdir.txt"

if exist "%CDD_LASTDIR%" del "%CDD_LASTDIR%" >nul 2>nul

if not exist "%CDD_EXE%" (
    echo Nao encontrei "%CDD_EXE%".
    echo Compile o C:\cdd\cddx.prg gerando C:\cdd\cddx.exe.
    endlocal
    exit /b 1
)

"%CDD_EXE%"

if exist "%CDD_LASTDIR%" (
    set /p "CDD_DIR="<"%CDD_LASTDIR%"
)

endlocal & if exist "%CDD_DIR%\" cd /d "%CDD_DIR%"
