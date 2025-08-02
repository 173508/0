@echo off
:: https://privacy.sexy — v0.12.5 — Tue, 17 Oct 2023 02:14:13 GMT
:: Ensure admin privileges
fltmc >nul 2>&1 || (
    echo Administrator privileges are required.
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
        pause & exit 1
    )
    exit 0
)


:: ----------------------------------------------------------
:: ------------------Kill OneDrive process-------------------
:: ----------------------------------------------------------
echo --- Kill OneDrive process
tasklist /fi "ImageName eq OneDrive.exe" /fo csv 2>NUL | find /i "OneDrive.exe">NUL && (
    echo OneDrive.exe is running and will be killed.
    taskkill /f /im OneDrive.exe
) || (
    echo Skipping, OneDrive.exe is not running.
)
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------------Remove OneDrive from startup---------------
:: ----------------------------------------------------------
echo --- Remove OneDrive from startup
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f 2>nul
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------Remove OneDrive through official installer--------
:: ----------------------------------------------------------
echo --- Remove OneDrive through official installer
if exist "%SystemRoot%\System32\OneDriveSetup.exe" (
    "%SystemRoot%\System32\OneDriveSetup.exe" /uninstall
) else (
    if exist "%SystemRoot%\SysWOW64\OneDriveSetup.exe" (
        "%SystemRoot%\SysWOW64\OneDriveSetup.exe" /uninstall
    ) else (
        echo Failed to uninstall, uninstaller could not be found. 1>&2
    )
)
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------------Remove OneDrive residual files--------------
:: ----------------------------------------------------------
echo --- Remove OneDrive residual files
:: OneDrive root folder
if exist "%UserProfile%\OneDrive" (
    rd "%UserProfile%\OneDrive" /q /s
)
:: OneDrive installation directory
if exist "%LOCALAPPDATA%\Microsoft\OneDrive" (
    rd "%LOCALAPPDATA%\Microsoft\OneDrive" /q /s
)
:: OneDrive data
if exist "%ProgramData%\Microsoft OneDrive" (
    rd "%ProgramData%\Microsoft OneDrive" /q /s
)
:: OneDrive cache
if exist "%SystemDrive%\OneDriveTemp" (
    rd "%SystemDrive%\OneDriveTemp" /q /s
)
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------------Remove OneDrive shortcuts-----------------
:: ----------------------------------------------------------
echo --- Remove OneDrive shortcuts
PowerShell -ExecutionPolicy Unrestricted -Command "$shortcuts = @(; @{ Revert = $True;  Path = "^""$env:APPDATA\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk"^""; }; @{ Revert = $False; Path = "^""$env:USERPROFILE\Links\OneDrive.lnk"^""; }; @{ Revert = $False; Path = "^""$env:WINDIR\ServiceProfiles\LocalService\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk"^""; }; @{ Revert = $False; Path = "^""$env:WINDIR\ServiceProfiles\NetworkService\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk"^""; }; ); foreach ($shortcut in $shortcuts) {; if (-Not (Test-Path $shortcut.Path)) {; Write-Host "^""Skipping, shortcut does not exist: `"^""$($shortcut.Path)`"^""."^""; continue; }; try {; Remove-Item -Path $shortcut.Path -Force -ErrorAction Stop; Write-Output "^""Successfully removed shortcut: `"^""$($shortcut.Path)`"^""."^""; } catch {; Write-Error "^""Encountered an issue while attempting to remove shortcut at: `"^""$($shortcut.Path)`"^""."^""; }; }"
PowerShell -ExecutionPolicy Unrestricted -Command "Set-Location "^""HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace"^""; Get-ChildItem | ForEach-Object {Get-ItemProperty $_.pspath} | ForEach-Object {; $leftnavNodeName = $_."^""(default)"^"";; if (($leftnavNodeName -eq "^""OneDrive"^"") -Or ($leftnavNodeName -eq "^""OneDrive - Personal"^"")) {; if (Test-Path $_.pspath) {; Write-Host "^""Deleting $($_.pspath)."^""; Remove-Item $_.pspath;; }; }; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------------------Disable OneDrive usage------------------
:: ----------------------------------------------------------
echo --- Disable OneDrive usage
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /t REG_DWORD /v "DisableFileSyncNGSC" /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /t REG_DWORD /v "DisableFileSync" /d 1 /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------Disable automatic OneDrive installation----------
:: ----------------------------------------------------------
echo --- Disable automatic OneDrive installation
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete "^""HKCU\Software\Microsoft\Windows\CurrentVersion\Run"^"" /v "^""OneDriveSetup"^"" /f 2>$null"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------Remove OneDrive folder from File Explorer---------
:: ----------------------------------------------------------
echo --- Remove OneDrive folder from File Explorer
reg add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /d "0" /t REG_DWORD /f
reg add "HKCR\Wow6432Node\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /d "0" /t REG_DWORD /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------------Disable OneDrive scheduled tasks-------------
:: ----------------------------------------------------------
echo --- Disable OneDrive scheduled tasks
PowerShell -ExecutionPolicy Unrestricted -Command "$tasks=$(; Get-ScheduledTask 'OneDrive Reporting Task-*'; Get-ScheduledTask 'OneDrive Standalone Update Task-*'; ); if($tasks.Length -eq 0) {; Write-Host 'Skipping, no OneDrive tasks exists.'; } else {; Write-Host "^""Total found OneDrive tasks: $($tasks.Length)."^""; foreach ($task in $tasks) {; $fullPath = $task.TaskPath + $task.TaskName; Write-Host "^""Deleting `"^""$fullPath`"^"""^""; schtasks /DELETE /TN "^""$fullPath"^"" /f; }; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------Clear OneDrive environment variable------------
:: ----------------------------------------------------------
echo --- Clear OneDrive environment variable
reg delete "HKCU\Environment" /v "OneDrive" /f 2>nul
:: ----------------------------------------------------------


pause
exit /b 0