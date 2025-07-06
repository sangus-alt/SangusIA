#!/bin/bash

set -e

echo
echo "=== Installation automatique de Sangus (Linux/Mac) ==="
echo

ROOT="$(cd "$(dirname "$0")"; pwd)"
BACKEND="$ROOT/backend"
FRONTEND="$ROOT/frontend"
WORKSPACE="$BACKEND/workspace"

# 1. Dossiers nécessaires
if [ ! -d "$WORKSPACE" ]; then
  mkdir -p "$WORKSPACE"
  echo "Dossier workspace créé."
fi

# 2. Backend : Python venv & dépendances
echo
echo "--- Configuration du backend Python ---"
cd "$BACKEND"
if [ ! -d "venv" ]; then
  python3 -m venv venv
  echo "Environnement virtuel Python créé."
fi
source venv/bin/activate

echo "Installation des paquets Python requis (fastapi uvicorn openai requests)..."
pip install --upgrade pip
pip install fastapi uvicorn openai requests

# 3. Frontend : npm install
echo
echo "--- Configuration du frontend (Node.js) ---"
cd "$FRONTEND"
if [ ! -d "node_modules" ]; then
  npm install
  echo "Dépendances Node installées."
fi

# 4. Ollama : téléchargement du modèle (si ollama installé)
echo
echo "--- Vérification d'Ollama ---"
if command -v ollama >/dev/null 2>&1; then
  echo "Ollama détecté. Téléchargement du modèle 'llama3' si nécessaire..."
  ollama pull llama3
  echo "Modèle 'llama3' téléchargé."
else
  echo "Ollama n'est pas installé. Pour l'IA locale, installe Ollama : https://ollama.com/download"
fi

# 5. Clé OpenAI (optionnelle)
echo
echo "Si tu utilises OpenAI, entre ta clé (sk-...) ou appuie Entrée pour ignorer :"
read -r OPENAI_KEY
if [ -n "$OPENAI_KEY" ]; then
  export OPENAI_API_KEY="$OPENAI_KEY"
  grep -qxF "export OPENAI_API_KEY=\"$OPENAI_KEY\"" "$HOME/.bashrc" 2>/dev/null || echo "export OPENAI_API_KEY=\"$OPENAI_KEY\"" >> "$HOME/.bashrc"
  echo "Clé OpenAI ajoutée dans ~/.bashrc (tu peux relancer le terminal pour l'appliquer partout)."
else
  echo "Clé OpenAI non définie. Seul Ollama sera utilisé pour l'IA générative."
fi

# 6. Instructions de lancement
echo
echo "=== Installation terminée ! ==="
echo
echo "Pour lancer Sangus :"
echo "1. Ouvre deux terminaux."
echo "2. Dans le premier :"
echo "   cd \"$BACKEND\""
echo "   source venv/bin/activate"
echo "   uvicorn main:app --reload"
echo "3. Dans le second :"
echo "   cd \"$FRONTEND\""
echo "   npm run dev"
echo "4. Va sur http://localhost:5173"
echo
echo "=== Bon usage de Sangus ! ==="
echo