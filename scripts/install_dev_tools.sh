#!/bin/bash

# =====================================================
# 🧑‍💻 INSTALACIÓN DE HERRAMIENTAS DE DESARROLLO
# =====================================================

print_title() {
    echo ""
    echo "============================================"
    echo " $1"
    echo "============================================"
    echo ""
}

install_pkg() {
    local pkg="$1"
    local desc="$2"

    print_title "Validando $desc"

    if brew list --cask "$pkg" &>/dev/null || brew list "$pkg" &>/dev/null; then
        echo "✔ $desc ya está instalado."
        return
    fi

    read -p "¿Instalar $desc? (y/n): " choice

    if [[ "$choice" == "y" ]]; then
        brew install "$pkg" || brew install --cask "$pkg"
        echo "✔ Instalado $desc"
    else
        echo "⚠ Saltado: $desc"
    fi
}

# --------------------------
# Herramientas Dev
# --------------------------
install_pkg "node" "Node.js"
install_pkg "python" "Python"
install_pkg "iterm2" "iTerm2"
install_pkg "android-studio" "Android Studio"
install_pkg "webstorm" "WebStorm"
install_pkg "intellij-idea-ce" "IntelliJ IDEA Community Edition"
install_pkg "visual-studio-code" "Visual Studio Code"
install_pkg "docker" "Docker"

print_title "Herramientas de desarrollo instaladas"
brew cleanup
