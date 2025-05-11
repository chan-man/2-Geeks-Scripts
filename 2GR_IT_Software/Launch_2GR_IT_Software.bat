@echo off
:: Check for Admin, re-launch if needed
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: Launch PowerShell GUI script
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0MainGUI.ps1"
