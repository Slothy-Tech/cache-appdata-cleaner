@echo off
setlocal

:: SlothyTech Cleaner Script
:: This script allows you to selectively clear temporary files and caches on Windows.
:: Choose from the menu to clear specific areas or all at once.
:: Run as administrator for best results.
:: Use with caution, as it permanently deletes files.

:menu
cls
echo Welcome to SlothyTech Cleaner!
echo Please choose what to clear:
echo 1. Windows Temp Folder
echo 2. User Temp Folder
echo 3. Chrome Cache
echo 4. Firefox Cache
echo 5. Edge Cache
echo 6. Recycle Bin
echo 7. All of the above
echo 8. Exit
set /p choice="Enter your choice (1-8): "

if "%choice%"=="1" goto clear_windows_temp
if "%choice%"=="2" goto clear_user_temp
if "%choice%"=="3" goto clear_chrome
if "%choice%"=="4" goto clear_firefox
if "%choice%"=="5" goto clear_edge
if "%choice%"=="6" goto clear_recycle_bin
if "%choice%"=="7" goto clear_all
if "%choice%"=="8" goto end
echo Invalid choice. Please try again.
pause
goto menu

:clear_windows_temp
cd /d C:\Windows\Temp
for /d %%p in (*) do rd /s /q "%%p"
del /q *.*
goto menu

:clear_user_temp
cd /d %TEMP%
for /d %%p in (*) do rd /s /q "%%p"
del /q *.*
goto menu

:clear_chrome
if exist "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache" (
    cd /d "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache"
    for /d %%p in (*) do rd /s /q "%%p"
    del /q *.*
)
goto menu

:clear_firefox
if exist "%LOCALAPPDATA%\Mozilla\Firefox\Profiles" (
    for /d %%p in ("%LOCALAPPDATA%\Mozilla\Firefox\Profiles\*") do (
        if exist "%%p\cache2" (
            cd /d "%%p\cache2"
            for /d %%q in (*) do rd /s /q "%%q"
            del /q *.*
        )
    )
)
goto menu

:clear_edge
if exist "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache" (
    cd /d "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache"
    for /d %%p in (*) do rd /s /q "%%p"
    del /q *.*
)
goto menu

:clear_recycle_bin
powershell -command "Clear-RecycleBin -Force"
goto menu

:clear_all
call :clear_windows_temp
call :clear_user_temp
call :clear_chrome
call :clear_firefox
call :clear_edge
call :clear_recycle_bin
goto menu

:end
echo Thank you for using SlothyTech Cleaner!
pause
exit
