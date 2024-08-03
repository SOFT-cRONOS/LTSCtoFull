@echo off
:menu
cls
echo ===================================
echo          Seleccione una opcion
call :colorText 34 "Seleccione una opcion."
echo ===================================
echo 1) Enterprise
echo 2) EnterpriseS
echo ===================================
set /p choice=Ingrese su eleccion (1 o 2): 

if "%choice%"=="1" goto enterprise
if "%choice%"=="2" goto enterprises
echo Opcion invalida. Por favor, intente de nuevo.
pause
goto menu

:enterprise
xcopy /s /i /y "C:\LTSCtoFull-main\content\Enterprise\*" "C:\Windows\System32\spp\tokens\skus"
echo Contenido copiado de Enterprise.
pause
goto fuller

:enterprises
xcopy /s /i /y "C:\LTSCtoFull-main\content\EnterpriseS\*" "C:\Windows\System32\spp\tokens\skus"
echo Contenido copiado de EnterpriseS.
pause
goto fuller

:fuller
echo Fuleando Windows
cscript.exe %windir%\system32\slmgr.vbs /rilc
cscript.exe %windir%\system32\slmgr.vbs /upk >nul 2>&1
cscript.exe %windir%\system32\slmgr.vbs /ckms >nul 2>&1
cscript.exe %windir%\system32\slmgr.vbs /cpky >nul 2>&1
cscript.exe %windir%\system32\slmgr.vbs /ipk M7XTQ-FN8P6-TTKYV-9D4CC-J462D
sc config LicenseManager start= auto & net start LicenseManager
sc config wuauserv start= auto & net start wuauserv
clipup -v -o -altto c:\
pause
goto end

:end
echo Fuleo completado
call :colorText 32 "Operación completada."
pause
exit

:colorText
setlocal
set "colorCode=%~1"
set "text=%~2"
for /f %%A in ('echo prompt $E ^| cmd') do set "ESC=%%A"
echo %ESC%[%colorCode%m%text%%ESC%[0m
endlocal
goto :eof
