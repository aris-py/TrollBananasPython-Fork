@echo off
setlocal
title banana omg

if not exist env (
    echo please run 'install-banana.bat' lol
    pause
    exit /b 1
)

env\python.exe main.py --open
echo.
pause