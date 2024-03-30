@echo off

title iOS Buster By Kamaldeep Bhati
rem Define color codes
set "CR=[1;31m"
set "CG=[1;32m"
set "CY=[1;33m"
set "CB=[1;34m"
set "CRSET=[0m"

echo.
echo %CR%=============================================================================================
echo =============================================================================================
echo -----------------^> iOS Buster by Kamaldeep Bhati @DarkLotusKDB ^<3 ^<------------------------
echo =============================================================================================
echo =============================================================================================%CRSET%
echo. 


:menu
echo.
echo %CG%=============================================
echo Please select an option from the following:
echo =============================================%CRSET%
echo %CY%
echo 1) Launch Frida and Objection Tool (Custom Checks)
echo 2) Security Access Control Missing From iOS Keychain
echo 3) Jailbreak Detection Bypass
echo 4) Certificate Pinning Bypass
echo 5) Biometric Authentication Bypass
echo 6) Generate Memory Dump Via Fridump Tool
echo 7) Client-Side Authentication Bypass
echo 8) Install/Upgrade Frida and Objection Tool
echo %CRSET%


set choice=
echo.
set /p choice=%CB%Enter your choice (1-7): %CRSET%

if "%choice%"=="1" (
    	call :MFrida
) else if "%choice%"=="2" (
	call :Frida
    	call :option2
) else if "%choice%"=="3" (
	call :Frida
   	call :option3
) else if "%choice%"=="4" (
	call :Frida
    	call :option4
) else if "%choice%"=="5" (
	call :Frida
    	call :option5
) else if "%choice%"=="6" (

    	call :option6
) else if "%choice%"=="7" (
	call :Frida
    	call :option7
) else if "%choice%"=="8" (
    	call :option8
) else (
    	echo Invalid choice. Please try again.
    	goto menu
)

goto menu



:option2

echo.
echo %CG%=============================================================================================
echo [+] Security Access Control Missing From iOS Keychain
echo =============================================================================================%CRSET%
objection -g %Pid% run "ios keychain dump"
objection -g %Pid% run "ios keychain dump --json ./output/keychain.json"
goto :eof







:option3
echo.

echo %CG%=============================================================================================
echo [+] Jailbreak Detection Bypass
echo =============================================================================================%CRSET%

echo.
echo %CY%[*] Trying with Objection tool (Once it's done, hit the 'Enter' key and type 'exit')
echo ----------------------------------------------------------------------------------------%CRSET%
pause
objection -g %Pid% explore --startup-command "ios jailbreak disable"

echo.
echo.
echo.
echo.

set answer=
call :Icom


set "folder=scripts\jb"

if not exist "%folder%" (
    echo The folder "%folder%" does not exist.
    exit /b
)

for %%F in ("%folder%\*.js") do (
echo.
echo %CY%[*] Trying with "%%~nxF" script - Once it's done, hit the 'Enter' key and type 'exit'.
echo ----------------------------------------------------------------------------------------%CRSET%
echo.
frida -U -f %Pid% -l scripts\jb\\"%%~nxF"

echo.
echo.
echo.
echo.

set answer=
call :Icom
)




goto :eof



:option4
echo.
echo %CG%=============================================================================================
echo [+] Certificate Pinning Bypass
echo =============================================================================================%CRSET%

echo.
echo %CY%[*] Trying with Objection tool (Once it's done, hit the 'Enter' key and type 'exit')
echo ----------------------------------------------------------------------------------------%CRSET%
pause
objection -g %Pid% explore --startup-command "ios sslpinning disable"

echo.
echo.
echo.
echo.

set answer=
call :Icom


set "folder=scripts\ssl"

if not exist "%folder%" (
    echo The folder "%folder%" does not exist.
    exit /b
)

for %%F in ("%folder%\*.js") do (
echo.
echo %CY%[*] Trying with "%%~nxF" script - Once it's done, hit the 'Enter' key and type 'exit'.
echo ----------------------------------------------------------------------------------------%CRSET%
echo.
frida -U -f %Pid% -l scripts\ssl\\"%%~nxF"

echo.
echo.
echo.
echo.

set answer=
call :Icom
)


goto :eof







:option5
echo.
echo %CG%=============================================================================================
echo [+] Biometric Authentication Bypass (iOS)
echo =============================================================================================%CRSET%

echo.
echo %CY%[*] Trying with Objection tool (Once it's done, hit the 'Enter' key and type 'exit')
echo --------------------------------------------------------------------------------------%CRSET%
pause
objection -g %Pid% explore -c scripts\bio\bio.txt
echo.
echo.
echo.

set answer=
call :Icom


set "folder=scripts\bio"

if not exist "%folder%" (
    echo The folder "%folder%" does not exist.
    exit /b
)

for %%F in ("%folder%\*.js") do (
echo.
echo %CY%[*] Trying with "%%~nxF" script - Once it's done, hit the 'Enter' key and type 'exit'.
echo ----------------------------------------------------------------------------------------%CRSET%
echo.
frida -U -f %Pid% -l scripts\bio\\"%%~nxF"

echo.
echo.
echo.
echo.

set answer=
call :Icom
)



goto :eof




:option6
echo.
echo %CG%=============================================================================================
echo [+] Generate Memory Dump Via Fridump Tool
echo =============================================================================================%CRSET%
echo. 
echo %CG%=============================================================================================
echo [+] Executing Frida Tool
echo =============================================================================================%CRSET%
echo.
frida-ps -Ua

set Pid=
:input
echo.
set /p Pid="%CB%Please enter the process Name (Ex: My App Uat): %CRSET%"
if "%Pid%"=="" (
 echo Input is required. Please try again.
    goto input
)
echo.
mkdir "output\dump_%Pid%"
python scripts\fridump\fridump.py -U -s "%Pid%" -o "output\dump_%Pid%"

goto :eof



:option7
echo.
echo %CG%=============================================================================================
echo [+] Client-Side Authentication Bypass
echo =============================================================================================%CRSET%
frida -U -l scripts\pin\PinLoginBypass.js -f %Pid%
echo.
echo [*] Now, on device enter any PIN such as "1234" or "123456".
echo.
echo.

set answer=
call :Icom

goto :eof





:option8
echo. 
echo %CG%=============================================================================================
echo [+] Installing Frida and Objection Tool
echo =============================================================================================%CRSET%
echo.
echo %CY%Note: Install the Python from the link below before proceeding further and relaunch the iOS Buster tool.%CRSET%
echo https://www.python.org/downloads/
echo.
pause

python -m pip install --upgrade pip

pip install frida

pip install frida-tools

pip install objection


:Ucom
set answer=
echo.
set /p answer=%CR%Do you want to update the tools? (y/n): %CRSET%

if /i "%answer%"=="Y" (
    	pip install --upgrade frida
	pip install --upgrade frida-tools
	pip install --upgrade objection
) else if /i "%answer%"=="N" (
	echo.
	goto menu
) else (
    echo Invalid input! Please enter either Y or N.
	goto Ucom
)
goto :eof

goto :eof



:Frida
echo. 
echo %CG%=============================================================================================
echo [+] Executing Frida Tool
echo =============================================================================================%CRSET%
echo.
frida-ps -Ua

set Pid=
:input
echo.
set /p Pid="%CB%Please enter the process Identifier (Ex: com.app.uat): %CRSET%"
if "%Pid%"=="" (
 echo Input is required. Please try again.
    goto input
)
echo.
goto :eof


:MFrida
echo. 
echo %CG%=============================================================================================
echo [+] Launch Frida and Objection Tool (Custom Checks)
echo =============================================================================================%CRSET%
echo.
call :Frida
objection -g %Pid% explore
goto :eof



:Icom
echo.

set /p answer=%CR%Did the above method work? (y/n): %CRSET%

if /i "%answer%"=="Y" (
    goto menu
) else if /i "%answer%"=="N" (
	echo.
) else (
    echo Invalid input! Please enter either Y or N.
	goto Icom
)
goto :eof

pause

