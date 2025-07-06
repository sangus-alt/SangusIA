import os

class PersonalAIAgent:
    def __init__(self, name="Assistant"):
        self.name = name
        self.commands = {}
        print(f"Bonjour ! Je suis {self.name}, votre assistant IA personnel. Comment puis-je vous aider aujourd'hui ?")

    def register_command(self, command_name, handler_function):
        """Enregistre une nouvelle commande avec sa fonction de gestionnaire."""
        self.commands[command_name.lower()] = handler_function

    def process_command(self, user_input):
        """Traite la commande de l'utilisateur en cherchant un gestionnaire enregistré."""
        user_input_lower = user_input.lower().strip()

        # Tentative de correspondance exacte ou par mot-clé principal
        for cmd_name, handler in self.commands.items():
            if cmd_name in user_input_lower:
                return handler(user_input) # Passer l'entrée complète au gestionnaire

        # Gestion des commandes génériques ou non reconnues
        if "bonjour" in user_input_lower or "salut" in user_input_lower:
            return "Bonjour ! Ravi de vous revoir."
        elif "quitte" in user_input_lower or "au revoir" in user_input_lower or "exit" in user_input_lower:
            return "Au revoir ! N'hésitez pas à me solliciter si vous avez d'autres besoins."
        else:
            return "Je n'ai pas compris votre demande. Pouvez-vous reformuler ?"

    # --- Méthodes pour les fonctionnalités spécifiques (seront implémentées progressivement) ---

    def _generate_content(self, user_input):
        """Génère du contenu textuel ou du code."""
        # Logique de génération de contenu/code ici
        return "Fonction de génération de contenu/code en cours de développement."

    def _interact_with_files(self, user_input):
        """Interagit avec les fichiers et documents."""
        # Logique d'interaction avec les fichiers ici
        return "Fonction d'interaction avec les fichiers en cours de développement."

    def _analyze_data(self, user_input):
        """Analyse des données."""
        # Logique d'analyse de données ici
        return "Fonction d'analyse de données en cours de développement."

    def _interact_with_applications(self, user_input):
        """Interagit avec d'autres applications."""
        # Logique d'interaction avec les applications ici
        return "Fonction d'interaction avec les applications en cours de développement."

    def _interact_with_databases(self, user_input):
        """Interagit avec les bases de données."""
        # Logique d'interaction avec les bases de données ici
        return "Fonction d'interaction avec les bases de données en cours de développement."

    def _interact_with_emails(self, user_input):
        """Interagit avec les emails."""
        # Logique d'interaction avec les emails ici
        return "Fonction d'interaction avec les emails en cours de développement."

# Boucle principale d'interaction
if __name__ == "__main__":
    agent = PersonalAIAgent("Sangus") # Vous pouvez lui donner le nom que vous voulez !

    # Enregistrement des commandes initiales
    agent.register_command("génère", agent._generate_content)
    agent.register_command("lis fichier", agent._interact_with_files)
    agent.register_command("analyse données", agent._analyze_data)
    agent.register_command("interagis application", agent._interact_with_applications)
    agent.register_command("base de données", agent._interact_with_databases)
    agent.register_command("email", agent._interact_with_emails)

    while True:
        user_input = input("Vous : ")
        response = agent.process_command(user_input)
        print(f"{agent.name} : {response}")
        if user_input.lower().strip() in ["quitte", "au revoir", "exit"]:
            break
