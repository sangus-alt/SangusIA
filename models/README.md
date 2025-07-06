# Modèles IA supportés dans Sangus

## Modèles Open Source (Ollama)

Sangus peut utiliser n'importe quel modèle compatible [Ollama](https://ollama.com/library). Voici quelques modèles recommandés :

- **llama3** : usage général (conversation, explications, etc.)
- **mistral** : rapide, performant sur le texte
- **codellama** : spécialisé génération/code

Installe un modèle avec :
```sh
ollama pull llama3
```
Puis sélectionne-le dans la config ou via l’interface.

**Astuce** : Les modèles téléchargés sont stockés dans `~/.ollama` (Linux/Mac) ou `%USERPROFILE%\.ollama` (Windows) et ne doivent PAS être versionnés.

---

## Modèles Cloud (OpenAI)

Ajoute ta clé API OpenAI pour activer :

- **gpt-3.5-turbo** : rapide, peu coûteux, bon par défaut
- **gpt-4** : plus cher, plus performant

Configure dans `models/models.json` ou dans le backend.

---

## Changer de modèle dans Sangus

- Modifie le fichier `models/models.json` pour changer le modèle par défaut (backend).
- Ou change la variable d’environnement `OLLAMA_MODEL` (pour Ollama) ou la clé OpenAI (pour OpenAI).
- Tu peux ajouter d’autres modèles supportés par Ollama en les ajoutant à ce fichier et en les téléchargeant.

---

## Ajouter un modèle personnalisé

1. Télécharge-le avec `ollama pull nom_du_modele`
2. Ajoute une entrée dans `models.json` pour le décrire
3. (Optionnel) Ajoute une documentation dans ce dossier

---