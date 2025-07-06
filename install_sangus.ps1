# Installation automatique de Sangus sur Windows

Write-Host "`n--- Installation automatique de Sangus ---`n"

$ErrorActionPreference = 'Stop'

# 1. Crée les dossiers nécessaires
$root = "$PSScriptRoot"
$backend = Join-Path $root "backend"
$frontend = Join-Path $root "frontend"
$workspace = Join-Path $backend "workspace"

if (!(Test-Path $workspace)) {
    New-Item -ItemType Directory -Path $workspace | Out-Null
    Write-Host "Dossier workspace créé."
}

# 2. Backend : Python venv & dépendances
Write-Host "`n--- Configuration du backend Python ---"
cd $backend
if (!(Test-Path ".\venv")) {
    python -m venv venv
    Write-Host "Environnement virtuel Python créé."
}
.\venv\Scripts\activate

Write-Host "Installation des paquets Python requis (fastapi uvicorn openai requests)..."
pip install --upgrade pip
pip install fastapi uvicorn openai requests

# 3. Frontend : npm install
Write-Host "`n--- Configuration du frontend (Node.js) ---"
cd $frontend
if (!(Test-Path "node_modules")) {
    npm install
    Write-Host "Dépendances Node installées."
}

# 4. Ollama : téléchargement du modèle (si ollama installé)
Write-Host "`n--- Vérification d'Ollama ---"
$ollama = Get-Command "ollama" -ErrorAction SilentlyContinue
if ($ollama) {
    Write-Host "Ollama détecté. Téléchargement du modèle 'llama3' si nécessaire..."
    ollama pull llama3
    Write-Host "Modèle 'llama3' téléchargé."
} else {
    Write-Host "Ollama n'est pas installé. Pour l'IA locale, installe Ollama via https://ollama.com/download"
}

# 5. Invite pour la clé OpenAI (optionnelle)
Write-Host "`nSi tu utilises OpenAI, entre ta clé (sk-...) ou appuie Entrée pour ignorer :"
$openaiKey = Read-Host "OpenAI API Key"
if ($openaiKey -ne "") {
    # Ajoute la clé à l'environnement utilisateur
    [Environment]::SetEnvironmentVariable("OPENAI_API_KEY", $openaiKey, "User")
    Write-Host "Clé OpenAI ajoutée dans les variables d'environnement utilisateur."
} else {
    Write-Host "Clé OpenAI non définie. Seul Ollama sera utilisé pour l'IA générative."
}

# 6. Instructions de lancement
Write-Host "`n--- Installation terminée ! ---`n"
Write-Host "Pour lancer Sangus :"
Write-Host "1. Ouvre deux terminaux."
Write-Host "2. Dans le premier :"
Write-Host "   cd $backend"
Write-Host "   .\venv\Scripts\activate"
Write-Host "   uvicorn main:app --reload"
Write-Host "3. Dans le second :"
Write-Host "   cd $frontend"
Write-Host "   npm run dev"
Write-Host "4. Va sur http://localhost:5173"

Write-Host "`n--- Bon usage de Sangus ! ---`n"