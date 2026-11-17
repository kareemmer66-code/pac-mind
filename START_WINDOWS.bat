@echo off
setlocal
cd /d "%~dp0"
title PAC-MIND - CF321 Search Lab
where node >nul 2>nul
if errorlevel 1 (
  echo Install Node.js LTS from https://nodejs.org then run this file again.
  pause
  exit /b 1
)
if not exist "node_modules\vite\bin\vite.js" (
  echo Installing project dependencies...
  call npm.cmd ci
  if errorlevel 1 (
    echo Installation failed. Check your internet connection and the error above.
    pause
    exit /b 1
  )
)
echo Starting PAC-MIND. Keep this window open. Press Ctrl+C to stop.
call npm.cmd run dev -- --open
pause
