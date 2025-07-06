# Tutoriel d'installation de Sangus sur Windows

## 1. Prérequis

- **Python 3.9 ou plus**  
  [Télécharger Python Windows](https://www.python.org/downloads/windows/)  
  > Vérifie que `python` fonctionne en ligne de commande :
  > ```cmd
  > python --version
  > ```

- **Node.js (18+) et npm**  
  [Télécharger Node.js](https://nodejs.org/en/download)  
  > Vérifie que `node` et `npm` fonctionnent :
  > ```cmd
  > node -v
  > npm -v
  > ```

- **Ollama** (pour IA locale, optionnel si tu veux seulement OpenAI)  
  [Télécharger Ollama Windows](https://ollama.com/download)

- (Optionnel) **Clé API OpenAI** (pour GPT-3.5/4)  
  [Créer une clé OpenAI](https://platform.openai.com/api-keys)

---

## 2. Structure des dossiers

Crée un dossier, par exemple `C:\sangus`, avec deux sous-dossiers :

```
C:\sangus
  ├── backend
  └── frontend
```

Copie tous les fichiers backend dans `C:\sangus\backend` et frontend dans `C:\sangus\frontend`.

---

## 3. Installation du backend

**Ouvre PowerShell ou CMD** :

```cmd
cd C:\sangus\backend
python -m venv venv
.\venv\Scripts\activate
pip install fastapi uvicorn openai requests
```

**Pour OpenAI**  
Ajoute ta clé dans la session PowerShell :

```cmd
$env:OPENAI_API_KEY="sk-...."
```
*(remplace sk-... par ta vraie clé)*

**Pour Ollama**  
- Installe puis lance Ollama (icône dans la barre d’icônes, ou via menu Démarrer)
- En PowerShell :
  ```cmd
  ollama pull llama3
  ```
  *(ou un autre modèle compatible)*

---

## 4. Installation du frontend

**Ouvre un autre PowerShell/CMD** :

```cmd
cd C:\sangus\frontend
npm install
npm run dev
```

---

## 5. Lancement du backend

Dans le terminal backend :

```cmd
cd C:\sangus\backend
.\venv\Scripts\activate
uvicorn main:app --reload
```

---

## 6. Accès à l’application

Ouvre ton navigateur sur :  
[http://localhost:5173](http://localhost:5173)

---

## 7. FAQ

- **Faut-il Internet ?**
  - **Pour OpenAI** : oui, il faut Internet.
  - **Pour Ollama** : Internet seulement pour télécharger le modèle la première fois, puis fonctionne hors-ligne.
  - **Pour l’édition/code/IA locale** : non, tout marche localement avec Ollama.
- **Ollama ne marche pas ?**
  - Vérifie qu’il tourne (icône verte en bas à droite de l’écran ou tape `ollama serve`)
  - Essaie de faire `ollama run llama3` pour tester.
- **Je veux changer de modèle IA ?**
  - Modifie la variable d’environnement `OLLAMA_MODEL` ou dans le code backend.

---

## 8. Problèmes fréquents

- **Erreur "module not found" ou "DLL load failed" (Python) :**  
  Mets à jour Python, vérifie que tu es bien dans le venv (`.\venv\Scripts\activate`).

- **Port déjà utilisé**  
  Arrête les autres serveurs sur le port 8000 (backend) ou 5173 (frontend), ou change les ports dans le code.

- **Dossier `workspace` introuvable**  
  Crée à la main `C:\sangus\backend\workspace` pour stocker tes fichiers de code.

---

**Besoin d’aide ou d’un script automatique ? Pose ta question !**