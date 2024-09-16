@echo off
setlocal enabledelayedexpansion
title bananas installer OMG

echo banana installer 
echo.

REM Define paths
set "INSTALL_DIR=%cd%"
set "MINICONDA_DIR=%UserProfile%\Miniconda3"
set "ENV_DIR=%INSTALL_DIR%\env"
set "MINICONDA_URL=https://repo.anaconda.com/miniconda/Miniconda3-py311_23.9.0-0-Windows-x86_64.exe"
set "CONDA_EXE=%MINICONDA_DIR%\Scripts\conda.exe"

call :cleanup
call :install_miniconda
call :create_conda_env
call :install_dependencies

echo banana game has been installed successfully lol
echo to start the game, please run 'banana.bat'.
echo.
pause
exit /b 0

:cleanup
echo cleaning up unnecessary files lol...
for %%F in (Makefile Dockerfile docker-compose.yaml *.sh) do if exist "%%F" del "%%F"
echo cleanup complete.
echo.
exit /b 0

:install_miniconda
if exist "%CONDA_EXE%" (
    echo miniconda already installed. skipping installation.
    exit /b 0
)

echo miniconda not found lol. starting download and installation xd...
powershell -Command "& {Invoke-WebRequest -Uri '%MINICONDA_URL%' -OutFile 'miniconda.exe'}"
if not exist "miniconda.exe" goto :download_error

start /wait "" miniconda.exe /InstallationType=JustMe /RegisterPython=0 /S /D=%MINICONDA_DIR%
if errorlevel 1 goto :install_error

del miniconda.exe
echo miniconda installation complete xd.
echo.
exit /b 0

:create_conda_env
echo Creating Conda environment with Python 3.11...
call "%MINICONDA_DIR%\_conda.exe" create --no-shortcuts -y -k --prefix "%ENV_DIR%" python=3.11
if errorlevel 1 goto :error
echo Conda environment created successfully.
echo.

if exist "%ENV_DIR%\python.exe" (
    echo installing specific pip version...
    "%ENV_DIR%\python.exe" -m pip install "pip<24.1"
    if errorlevel 1 goto :error
    echo pip installation complete.
    echo.
)
exit /b 0

:install_dependencies
echo installing dependencies...
call "%MINICONDA_DIR%\condabin\conda.bat" activate "%ENV_DIR%" || goto :error
pip install --upgrade setuptools || goto :error
pip install -r "%INSTALL_DIR%\requirements.txt" || goto :error
call "%MINICONDA_DIR%\condabin\conda.bat" deactivate
echo dependencies installation complete.
echo.
exit /b 0

:download_error
echo download failed lol. please check your bad internet connection and try again xd.
goto :error

:install_error
echo miniconda installation failed noob.
goto :error

:error
echo an error occurred during installation XD. please check the output above for details lol.
pause
exit /b 1
