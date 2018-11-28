@echo off

:: Set the update version to check exe against
set VERSION=Version=4.4.412.1942

:: Get the exe current version
wmic datafile where name="C:\\Program Files (x86)\\Solutions POS\\Solutions POS.exe" get Version /value > temp.txt

for /f %%i in ('type temp.txt') do set VAR=%%i

:: Delete temp file
del temp.txt

:: Compare exe version against update version
if "%VERSION%" EQU "%VAR%" (
  echo Update Success!
  exit 0
)
:: exe wasn't updated for some reason
echo Update Failed. .exe version: %VAR%, Update Version: %VERSION%
exit 1
