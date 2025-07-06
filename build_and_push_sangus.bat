@echo off
REM Ce script batch build le frontend (React), freeze le backend (PyInstaller), et pousse tout sur la branche Sangus-IA

REM 1. Build frontend
cd frontend
call npm install
call npm run build
cd ..

REM 2. Freeze backend (PyInstaller doit être installé dans le venv)
cd backend
call venv\Scripts\activate
pip install pyinstaller
pyinstaller --onefile --add-data "workspace;workspace" main.py
cd ..

REM 3. Commit et push sur la branche Sangus-IA
git checkout Sangus-IA
git add .
git commit -m "Build automatique frontend+backend (.exe) et push"
git push origin Sangus-IA

echo Build et push terminés !
pause