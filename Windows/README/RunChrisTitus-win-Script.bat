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

PowerShell -ExecutionPolicy Unrestricted -Command "iwr -useb https://christitus.com/win | iex"


pause
exit /b 0