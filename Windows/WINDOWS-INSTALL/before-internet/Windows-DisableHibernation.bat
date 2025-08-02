@echo off
:: https://privacy.sexy — v0.12.5 — Tue, 17 Oct 2023 02:15:31 GMT
:: Ensure admin privileges
fltmc >nul 2>&1 || (
    echo Administrator privileges are required.
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
        pause & exit 1
    )
    exit 0
)


:: Disable hibernation for faster startup and to avoid sensitive data storage
echo --- Disable hibernation for faster startup and to avoid sensitive data storage
powercfg -h off
:: ----------------------------------------------------------


pause
exit /b 0