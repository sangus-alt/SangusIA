# Script PowerShell pour builder le frontend, freezer le backend, et pousser sur la branche Sangus-IA

Write-Host "=== Build et push de Sangus ==="

# 1. Build frontend
cd frontend
npm install
npm run build
cd ..

# 2. Freeze backend
cd backend
.\venv\Scripts\activate
pip install pyinstaller
pyinstaller --onefile --add-data "workspace;workspace" main.py
cd ..

# 3. Commit et push
git checkout Sangus-IA
git add .
git commit -m "Build automatique frontend+backend (.exe) et push"
git push origin Sangus-IA

Write-Host "Build et push terminés !"
pause