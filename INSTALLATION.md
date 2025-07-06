# 🚀 Tutoriel d’installation de Sangus (étape par étape, très détaillé)

Ce guide vous accompagne pas à pas, même si vous débutez !  
Sangus fonctionne sur Linux, macOS et Windows.  
**Prérequis** : accès internet, droits administrateur, et un terminal (cmd/PowerShell sous Windows).

---

## 1. Prérequis logiciels (à installer une seule fois)

### 1.1. Python (version 3.10+ recommandé)
- **Linux/Mac** :  
  Ouvrez un terminal et tapez :  
  ```sh
  python3 --version
  ```
  Si Python n’est pas installé ou trop ancien :  
  ```sh
  sudo apt update && sudo apt install python3 python3-venv python3-pip
  ```
  ou, sur Mac :  
  ```sh
  brew install python
  ```

- **Windows** :  
  Téléchargez Python sur [python.org](https://www.python.org/downloads/), cochez **“Add Python to PATH”** à l’installation, puis vérifiez :  
  ```bat
  python --version
  ```

### 1.2. Node.js (v18+ recommandé) & npm
- **Linux/Mac** :  
  ```sh
  node --version
  npm --version
  ```
  Si non installés :  
  ```sh
  curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
  sudo apt-get install -y nodejs
  ```
  ou, sur Mac :  
  ```sh
  brew install node
  ```

- **Windows** :  
  [Téléchargez Node.js LTS](https://nodejs.org/) et installez-le.

### 1.3. (Optionnel mais recommandé) [Ollama](https://ollama.com/) pour IA locale
- Téléchargez et installez Ollama : https://ollama.com/download  
- Lancez-le une fois (il tourne en tâche de fond).
- Test rapide :  
  ```sh
  ollama list
  ```
  (Doit afficher les modèles disponibles/localement)

### 1.4. (Optionnel) Git
- Pour cloner Sangus et gérer le code source.
  ```sh
  git --version
  ```
  Si non installé :
  - **Linux** : `sudo apt install git`
  - **Mac** : `brew install git`
  - **Windows** : [Téléchargez Git](https://git-scm.com/download/win)

---

## 2. Récupération du projet Sangus

### 2.1. Cloner depuis GitHub (recommandé)
Ouvrez un terminal dans le dossier où vous voulez Sangus, puis tapez :
```sh
git clone https://github.com/<TON-UTILISATEUR>/<REPO-SANGUS>.git
cd <REPO-SANGUS>
```
Remplace `<TON-UTILISATEUR>` et `<REPO-SANGUS>` par ton nom d’utilisateur et le nom du dépôt.

### 2.2. Ou télécharger l’archive ZIP
- Clique sur “Code” > “Download ZIP” sur la page GitHub.
- Décompresse le dossier, puis `cd` dedans dans ton terminal.

---

## 3. Installation du backend Python (API Sangus)

```sh
cd backend
python3 -m venv venv
source venv/bin/activate            # Linux/Mac
venv\Scripts\activate               # Windows
pip install --upgrade pip
pip install -r requirements.txt     # ou pip install fastapi uvicorn openai # si pas de fichier
```

**Astuce :**  
Si tu veux activer/désactiver l’environnement virtuel, tape `deactivate` (pour sortir), puis répète la commande `source` ou `venv\Scripts\activate` pour revenir.

---

## 4. Installation du frontend React

```sh
cd ../frontend
npm install
```

---

## 5. (Optionnel mais conseillé) Télécharger un modèle IA local avec Ollama

Pour Llama3 (modèle généraliste, open-source) :
```sh
ollama pull llama3
```
Pour un modèle code (CodeLlama) :
```sh
ollama pull codellama
```
Tu peux voir tous les modèles sur https://ollama.com/library

---

## 6. Configuration des variables d’environnement

### Backend (`backend/.env`)
Crée (ou édite) un fichier `.env` dans le dossier `backend` pour ajouter :
```
# Exemple de config Ollama (local)
OLLAMA_MODEL=llama3
OLLAMA_HOST=http://localhost:11434

# (Optionnel) OpenAI
OPENAI_API_KEY=sk-...
OPENAI_MODEL=gpt-3.5-turbo
```

### Frontend (`frontend/.env`)
Tu peux indiquer le port de l’API par exemple :
```
VITE_API_URL=http://localhost:8000
```

> **Remarque :** Les fichiers `.env` sont ignorés par git, ne les partage pas publiquement.

---

## 7. Lancer Sangus

### 7.1. Lancer le backend
Dans le dossier `backend`, terminal activé dans le venv :
```sh
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```
- L’API est dispo sur http://localhost:8000

### 7.2. Lancer le frontend
Dans un autre terminal :
```sh
cd frontend
npm run dev
```
- L’interface est sur http://localhost:5173 (ou autre port affiché)

---

## 8. Utilisation

- Ouvre l’URL du frontend dans ton navigateur.
- Change le modèle IA dans l’interface si besoin.
- Commence à créer des codes sources, demander des corrections, tests, suggestions…

---

## 9. (Optionnel) Personnalisation

- Change le logo et les couleurs (dans `frontend/public/` et `frontend/src/colors.css`)
- Ajoute tes propres modèles IA (voir dossier `models/`)
- Ajoute/édite les fichiers `.env` pour plus de configuration

---

## 10. En cas de problème

- **Erreur “module not found”** : vérifie que le venv est activé, relance `pip install ...`
- **Erreur “port déjà utilisé”** : change le port dans `.env` ou dans la commande `uvicorn`
- **Problème d’IA** : assure-toi qu’Ollama tourne (`ollama list`) ou que ta clé OpenAI est valide

---

## 11. Pour aller plus loin

- Mets à jour les dépendances régulièrement (`pip install -U ...`, `npm update`)
- Consulte la documentation des modèles IA sur https://ollama.com/library
- Forke le projet, propose des améliorations, partage avec la communauté !

---

**Bravo, Sangus est prêt à servir dans toutes tes tâches de code et d’IA !**
