@echo off
setlocal

REM Check for elevated priviledges 
net session >nul 2>&1
IF %ERRORLEVEL% NEQ 0 GOTO ELEVATE

REM Check if any parameters have been given.
if "%*"=="" (
  echo No version parameter given.
  echo Usage: 			Use the command 'jdk version',  eg. 'jdk 1.6'
  echo Possible options: 	1.6, 1.7, 1.8
  echo ---------
  echo Choose Option now:
  echo   1. for JDK 1.6
  echo   2. for JDK 1.7
  echo   3. for JDK 1.8
  
  CHOICE /C 123 /M "Enter your choice:"

  :: Note - list ERRORLEVELS in decreasing order
  IF ERRORLEVEL 3 (
	set PARAM=1.8
  )
  IF ERRORLEVEL 2 (
	set PARAM=1.7
  )
  IF ERRORLEVEL 1 (
    set PARAM=1.6
  )
) else (
    set PARAM=%1
)

REM echo PARAM = %PARAM%

if "%PARAM%"=="1.6" (
    set JAVA_VERSION=jdk1.6.0_45
) else (
	if "%PARAM%"=="1.7" (
    set JAVA_VERSION=jdk1.7.0_79
  ) else (
	if "%PARAM%"=="1.8" (
	  set JAVA_VERSION=jdk1.8.0_162
    ) else (
  echo ERROR: 			Version is not set according to available options - see options below
  echo Usage: 			Use the command "jdk version",  eg. "jdk 1.6"
  echo Possible options: 	1.6, 1.7, 1.8, 12, 13
  exit /b
)))

echo ----------------------------
echo JAVA-Version: %JAVA_VERSION%
echo ----------------------------


echo Trying to remove current JAVA path from PATH
echo (Using tool "pathed" - http://p-nand-q.com/download/gtools/pathed.html)
pathed /REMOVE "%JDK_HOME%\bin" /MACHINE

echo ----------------------------
echo setting PATH unsing "pathed"
pathed /APPEND "C:\Program Files\Java\%JAVA_VERSION%\bin" /MACHINE 

echo ----------------------------
echo Removing duplicates from PATH
pathed  /SLIM /MACHINE

echo ----------------------------
echo Setting JAVA_HOME
set JAVA_HOME="C:\Program Files\Java\%JAVA_VERSION%"
setx JAVA_HOME "C:\Program Files\Java\%JAVA_VERSION%" /m

echo ----------------------------
echo Setting JDK_HOME
set JDK_HOME="C:\Program Files\Java\%JAVA_VERSION%"
setx JDK_HOME "C:\Program Files\Java\%JAVA_VERSION%" /m

echo Display java version
java -version
SLEEP 5
@ECHO on
EXIT /B 0

:ELEVATE
ECHO Elevated privileges are  required to run script. 
ECHO Aborting
SLEEP 5
@ECHO on
EXIT /B 0