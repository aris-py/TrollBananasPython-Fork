from cx_Freeze import setup, Executable
import os

include_files = ['banana1.png', 'bomb.png']

packages = ['tkinter', 'ctypes', 'pyautogui', 'random']

executables = [
    Executable(
        "main.py",  
        base="Win32GUI",  
        target_name="TrollBananas.exe",  
        icon="aris-py/TrollBananasPython-Fork/favicon.ico"  
    )
]

setup(
    name="TrollBananas",
    version="1.0",
    description="A troll banana game",
    options={
        'build_exe': {
            'packages': packages,        
            'include_files': include_files,  
            'include_msvcr': True,      
            'build_exe': "output",       
        }
    },
    executables=executables
)
