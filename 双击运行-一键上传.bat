@echo off
chcp 65001 >nul
set SCRIPT_DIR=%~dp0
powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%一键上传到GitHub.ps1"
pause
