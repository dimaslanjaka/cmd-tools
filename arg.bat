@echo off
if "%~1"=="" (
    echo No parameters have been provided.
) else (
    rem echo Parameters: %*
    if "%~1"=="verify" goto verify
)

EXIT /B 0

:verify
	echo "Verifying Installation"
	.\vs_community.exe --layout "%~dp0" --verify
GOTO MENU