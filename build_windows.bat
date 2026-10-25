@echo off
setlocal
cd /d "%~dp0"

echo Installation des dependances necessaires a la creation de l'application...
python -m pip install -r requirements-build.txt
if errorlevel 1 goto failed

echo Construction du fichier Windows...
python -m PyInstaller --noconfirm --clean --onefile --windowed --name Sabiloul_houda --icon "%~dp0assets\logo_sabiloul_houda.ico" --add-data "%~dp0assets\logo_sabiloul_houda.png;assets" --specpath build --workpath build\pyinstaller --distpath dist --collect-all reportlab --collect-all openpyxl --collect-all arabic_reshaper --collect-all bidi src\main.py
if errorlevel 1 goto failed

echo.
echo Application creee dans le dossier dist.
pause
exit /b 0

:failed
echo.
echo La construction a echoue. Verifiez Python, Internet et les messages ci-dessus.
pause
exit /b 1
