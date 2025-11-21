#!/bin/bash

# =====================================================
# 📦 INSTALACIÓN DE APPS BÁSICAS
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

    if brew list --cask "$pkg" &>/dev/null; then
        echo "✔ $desc ya está instalado."
        return
    fi

    read -p "¿Instalar $desc? (y/n): " choice

    if [[ "$choice" == "y" ]]; then
        brew install --cask "$pkg"
        echo "✔ Instalado $desc"
    else
        echo "⚠ Saltado $desc"
    fi
}

# --------------------------
# Apps básicas
# --------------------------
install_pkg "google-chrome" "Google Chrome"
install_pkg "rectangle" "Rectangle"
install_pkg "spotify" "Spotify"

print_title "Apps básicas instaladas"
