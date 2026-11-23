@echo off
setlocal EnableExtensions DisableDelayedExpansion
REM Local Administrator GPO Deployment - Nisar Muhammad, copyright 2026
REM ISOLATED LAB ONLY. This file stores the configured password in plaintext.
REM #CHANGE USERNAME - Enter your preferred local administrator username
set "AdminUser=CHANGE_USERNAME"

REM #CHANGE PASSWORD - Enter your preferred local administrator password
set "AdminPass=CHANGE_PASSWORD"

set "NET=%SystemRoot%\System32\net.exe"
set "FIND=%SystemRoot%\System32\findstr.exe"
set "WMIC=%SystemRoot%\System32\wbem\WMIC.exe"
if not exist "%WMIC%" if exist "%SystemRoot%\Sysnative\wbem\WMIC.exe" set "WMIC=%SystemRoot%\Sysnative\wbem\WMIC.exe"

if not defined AdminUser goto :ConfigFailed
if not defined AdminPass goto :ConfigFailed
set AdminUser | "%FIND%" /i /x /l /c:"AdminUser=CHANGE_USERNAME" >nul && goto :ConfigFailed
set AdminPass | "%FIND%" /i /x /l /c:"AdminPass=CHANGE_PASSWORD" >nul && goto :ConfigFailed
set AdminUser | "%FIND%" /r /x /c:"AdminUser=[A-Za-z][A-Za-z0-9_-]*" >nul || goto :ConfigFailed
set AdminPass | "%FIND%" /r /x /c:"AdminPass=[A-Za-z0-9][A-Za-z0-9_@+=.,:#-]*" >nul || goto :ConfigFailed
if not "%AdminUser:~20,1%"=="" goto :ConfigFailed
if "%AdminPass:~11,1%"=="" goto :ConfigFailed
if not "%AdminPass:~127,1%"=="" goto :ConfigFailed
if not exist "%WMIC%" goto :WmicMissing

rem Limit this example to Windows clients and verify required commands first.
"%WMIC%" os get ProductType /value 2>nul | "%FIND%" /i /x /l /c:"ProductType=1" >nul || goto :PlatformFailed
"%NET%" localgroup Administrators >nul 2>&1 || goto :GroupFailed
set "AccountFilter=LocalAccount=True And Name='%AdminUser%'"
rem Reject built-in accounts if somebody configured a renamed built-in identity.
"%WMIC%" useraccount where "%AccountFilter%" get SID /value 2>nul | "%FIND%" /r /x /c:"SID=.*-[1-9][0-9][0-9]" >nul && goto :PlatformFailed

"%NET%" user "%AdminUser%" >nul 2>&1
if errorlevel 1 goto :Create
set "AdminPass="
"%NET%" user "%AdminUser%" /active:yes /expires:never /passwordchg:no >nul 2>&1 || goto :AccountFailed
goto :Ensure

:Create
setlocal EnableDelayedExpansion
"!NET!" user "!AdminUser!" "!AdminPass!" /add /active:yes /expires:never /passwordchg:no >nul 2>&1
if errorlevel 1 (
    endlocal
    goto :AccountFailed
)
endlocal
set "AdminPass="

:Ensure
"%WMIC%" useraccount where "%AccountFilter%" get PasswordExpires /value 2>nul | "%FIND%" /i /x /l /c:"PasswordExpires=FALSE" >nul
if not errorlevel 1 goto :Membership
"%WMIC%" useraccount where "%AccountFilter%" set PasswordExpires=False >nul 2>&1 || goto :ExpirationFailed
"%WMIC%" useraccount where "%AccountFilter%" get PasswordExpires /value 2>nul | "%FIND%" /i /x /l /c:"PasswordExpires=FALSE" >nul || goto :ExpirationFailed

:Membership
call :IsMember
if not errorlevel 1 goto :Success
"%NET%" localgroup Administrators "%COMPUTERNAME%\%AdminUser%" /add >nul 2>&1 || goto :GroupFailed
call :IsMember
if errorlevel 1 goto :GroupFailed

:Success
echo Local account enabled. Password expiration disabled. Direct Administrators membership verified.
exit /b 0

:IsMember
"%NET%" localgroup Administrators 2>nul | "%FIND%" /i /x /l /c:"%AdminUser%" /c:"%COMPUTERNAME%\%AdminUser%" >nul
exit /b %ERRORLEVEL%

:ConfigFailed
>&2 echo Invalid lab configuration. Replace both placeholders and check the documented input rules.
exit /b 1

:WmicMissing
>&2 echo WMIC is unavailable. No account changes were made.
exit /b 1

:PlatformFailed
>&2 echo A Windows lab client and a custom local account are required.
exit /b 1

:AccountFailed
set "AdminPass="
>&2 echo Could not create or enable the local account. Check elevation and local account policy.
exit /b 1

:ExpirationFailed
>&2 echo Could not set or verify password non-expiration. Check the target for partial changes.
exit /b 1

:GroupFailed
>&2 echo Could not read or verify the English Administrators group. Check the target for partial changes.
exit /b 1

