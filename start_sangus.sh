#!/bin/bash

set -e

ROOT="$(cd "$(dirname "$0")"; pwd)"
BACKEND="$ROOT/backend"
FRONTEND="$ROOT/frontend"

echo
echo "=== Lancement automatique de Sangus (Backend, Frontend, Ollama) ==="
echo

# 1. Lancer Ollama (optionnel, si installé)
if command -v ollama >/dev/null 2>&1; then
  echo "[*] Démarrage d'Ollama (pour IA locale)..."
  if ! pgrep -x "ollama" > /dev/null; then
    gnome-terminal -- bash -c "ollama serve; exec bash" 2>/dev/null || \
    x-terminal-emulator -e "ollama serve" 2>/dev/null || \
    ollama serve &
    sleep 2
  else
    echo "Ollama déjà lancé."
  fi
else
  echo "Ollama non trouvé (pas d'IA locale)."
fi

sleep 1

# 2. Lancer le backend (FastAPI)
echo "[*] Lancement du backend Python (uvicorn)..."
cd "$BACKEND"
source venv/bin/activate
gnome-terminal -- bash -c "cd '$BACKEND'; source venv/bin/activate; uvicorn main:app --reload; exec bash" 2>/dev/null || \
x-terminal-emulator -e "bash -c 'cd \"$BACKEND\"; source venv/bin/activate; uvicorn main:app --reload; exec bash'" 2>/dev/null || \
(uvicorn main:app --reload &)

sleep 2

# 3. Lancer le frontend (React)
echo "[*] Lancement du frontend React..."
cd "$FRONTEND"
gnome-terminal -- bash -c "cd '$FRONTEND'; npm run dev; exec bash" 2>/dev/null || \
x-terminal-emulator -e "bash -c 'cd \"$FRONTEND\"; npm run dev; exec bash'" 2>/dev/null || \
(npm run dev &)

sleep 2

echo
echo "=== Sangus est en cours de lancement ==="
echo "→ Frontend : http://localhost:5173"
echo "→ Backend  : http://localhost:8000"
echo
echo "Si une fenêtre ne s'est pas ouverte, lance manuellement dans deux terminaux :"
echo "1. cd $BACKEND && source venv/bin/activate && uvicorn main:app --reload"
echo "2. cd $FRONTEND && npm run dev"
echo

exit 0