@echo off

:: Define Error Constants
SET /A POS_NOT_INSTALLED=22
SET /A POS_RUNNING=23

:: Run Upgrader
start /wait "Solutions POS Upgrader" C:\temp\upgrader.exe /S
set returnCode=%ERRORLEVEL%

:: If there is an error, Print the type and exit with corresponding error code.
if /I "%returnCode%" EQU "%POS_NOT_INSTALLED%" (
    echo Unable to update Solutions POS. Application not installed.
    exit %POS_NOT_INSTALLED%
)

if /I "%returnCode%" EQU "%POS_RUNNING%" (
    echo Unable to update Solutions POS. Application running.
    exit %POS_RUNNING%
)

:: No errors. Return Success.
exit 0
