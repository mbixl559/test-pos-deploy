@echo off

:: Define Error Constants
SET /A POS_NOT_INSTALLED=22
SET /A POS_RUNNING=23
SET /A SQL_UPDATE_FAILED=24

SET ROLLBACK=False

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

if /I "%returnCode%" EQU "%SQL_UPDATE_FAILED%" (
    echo Unable to update Solutions POS. SQL Update Failed.
    set ROLLBACK=True
)

if /I "%ROLLBACK%" EQU "True" (
    rmdir /Q /S "C:\Program Files (x86)\Solutions POS"
    start /wait "POS Rollback" robocopy "C:\ProgramData\Solutions POS\Backup" "C:\Program Files (x86)\Solutions POS"
)

:: No errors. Return Success.
exit 0
