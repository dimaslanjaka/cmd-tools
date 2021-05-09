@echo off
rem .\vs_community.exe --layout --add Microsoft.VisualStudio.Workload.NativeDesktop --includeRecommended --lang en-US
rem https://docs.microsoft.com/en-us/visualstudio/install/command-line-parameter-examples?view=vs-2019

rem Menu function always executed on first execution
:MENU
	ECHO.
	ECHO ...............................................
	ECHO Select task.
	ECHO ...............................................
	ECHO.
	ECHO 1 - Verify Installation
	ECHO 2 - Fix Installation
	ECHO 3 - Update Installer
	ECHO 4 - Update App Itself
	echo 5 - Uninstall Installation
	ECHO.
	SET /P M="Type (number) then press ENTER:"
	IF %M%==1 (
		cls
		GOTO verify
	)
	IF %M%==2 (
		cls
		GOTO fix
	)
	IF %M%==3 (
		cls
		GOTO upInstaller
	)
	IF %M%==4 (
		cls
		GOTO upApp
	)
	IF %M%==5 (
		cls
		GOTO uninstall
	)
	EXIT /B 0

rem verify
:verify
	echo "Verifying Installation"
	.\vs_community.exe --layout "%~dp0" --verify
GOTO MENU

rem update vs app itself
:upApp
	echo "Updating App"
	.\vs_community.exe update --installPath "%~dp0" --quiet --wait --norestart
GOTO MENU

rem update installer
:upInstaller
	echo "Updating Installer"
	.\vs_community.exe --quiet --update
GOTO MENU

rem fix
:fix
	echo "Fixing Installation"
	.\vs_community.exe --layout "%~dp0" --fix
GOTO MENU

rem uninstall
:uninstall
	echo "Uninstalling Installation"
	.\vs_community.exe uninstall --layout "%~dp0"
GOTO MENU

rem export
:export
	.\vs_community.exe export --installPath "%~dp0" --config "C:\.vsconfig"
GOTO MENU