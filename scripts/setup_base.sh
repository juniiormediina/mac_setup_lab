#!/bin/bash

# =====================================================
# ⚙️ BASE SETUP — Validaciones + Configs Iniciales
# =====================================================

print_title() {
    echo ""
    echo "============================================"
    echo " $1"
    echo "============================================"
    echo ""
}

# --------------------------
# 1. Validar Homebrew
# --------------------------
print_title "Validando Homebrew"

if ! command -v brew &>/dev/null; then
    echo "⚠ Homebrew no está instalado."
    read -p "¿Deseas instalarlo? (y/n): " hb

    if [[ "$hb" == "y" ]]; then
        echo "➡ Instalando Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        echo >> "$HOME/.zprofile"
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"

        eval "$(/opt/homebrew/bin/brew shellenv)"

        echo "✔ Homebrew instalado y configurado."
    else
        echo "❌ No se puede continuar sin Homebrew. Abortando."
        exit 1
    fi
else
    echo "✔ Homebrew ya está instalado."
fi

brew update

# --------------------------
# 2. Instalar Git (si falta)
# --------------------------
print_title "Validando Git"

if ! command -v git &>/dev/null; then
    echo "⚠ Git no encontrado. Instalando..."
    brew install git
else
    echo "✔ Git ya está instalado."
fi

# --------------------------
# 3. Configurar carpeta Development
# --------------------------
print_title "Creando carpeta ~/Development"

DEV_DIR="$HOME/Development"

mkdir -p "$DEV_DIR"
echo "✔ Carpeta Development lista."

# --------------------------
# 4. Configurar Screenshots
# --------------------------
print_title "Configurando ubicación de Screenshots"

mkdir -p ~/Documents/Screenshots
defaults write com.apple.screencapture location ~/Documents/Screenshots
killall SystemUIServer

echo "✔ Screenshots configurados."

# --------------------------
# 5. Preguntar por instalación de dev tools
# --------------------------
print_title "¿Deseas instalar herramientas de desarrollo?"
read -p "(y/n): " dev_choice

if [[ "$dev_choice" == "y" ]]; then
    echo "➡ Se instalarán las herramientas de desarrollo."
    ./install_dev_tools.sh
else
    echo "⚠ Saltado: herramientas de desarrollo"
fi

print_title "Base Setup Completado"
echo "Ahora ejecuta: ./install_basic_apps.sh"
