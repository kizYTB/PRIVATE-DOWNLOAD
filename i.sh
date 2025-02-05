#!/bin/bash

# Installation des paquets nécessaires
sudo apt update && sudo apt install -y figlet toilet

# Création du fichier de message MOTD
sudo tee /etc/update-motd.d/99-custom-motd > /dev/null <<EOL
#!/bin/bash

# Couleurs ANSI
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
RESET='\033[0m'  # Réinitialiser la couleur

# Générer une bannière avec figlet
echo -e "\${CYAN}\$(figlet -f slant Jtheberg.cloud)\${RESET}"

echo -e "\${YELLOW}- Nom d'hôte : \$(hostname)\${RESET}"
echo -e "\${YELLOW}- Adresse IP : \$(hostname -I)\${RESET}"
echo -e "\${YELLOW}- Système d'exploitation : \$(lsb_release -d | cut -f2)\${RESET}"
echo -e "\${YELLOW}- Temps de fonctionnement : \$(uptime -p)\${RESET}"
echo -e "\${YELLOW}- Utilisation de la mémoire : \$(free -h | awk '/Mem:/ {print \$3 " / " \$2}')\${RESET}"
echo -e "\${YELLOW}- Utilisation du disque : \$(df -h / | awk 'NR==2 {print \$3 " / " \$2}')\${RESET}"
EOL

# Donner les permissions d'exécution
sudo chmod +x /etc/update-motd.d/99-custom-motd

# Mettre à jour le système
sudo apt update && sudo apt-get upgrade -f -y --force-yes
