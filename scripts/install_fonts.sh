#!/usr/bin/env bash

# =========================================
# install_fonts.sh
# Instala MesloLGS Nerd Font (requerida por
# Powerlevel10k) de forma idempotente.
# =========================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./utils.sh
source "$SCRIPT_DIR/utils.sh"

FONT_NAME="MesloLGS Nerd Font"
FONT_FILE="$HOME/Library/Fonts/MesloLGSNerdFont-Regular.ttf"
CASK_NAME="font-meslo-lg-nerd-font"

print_header "Instalación de fuentes (Powerlevel10k)"

if ! command_exists brew; then
  abort "Homebrew es requerido para instalar fuentes."
fi

# ✅ Si la fuente ya está disponible en el sistema, salir
if [[ -f "$FONT_FILE" ]]; then
  log_info "$FONT_NAME ya está instalada en el sistema."
else
  print_step "Instalando $FONT_NAME vía Homebrew..."
  brew install --cask "$CASK_NAME" || true
  log_success "$FONT_NAME instalada."
fi

print_blank

# ✅ Hint guiado para iTerm2 (no automatizable por Apple)
if [[ "${TERM_PROGRAM:-}" == "iTerm.app" ]]; then
  log_info "Configuración manual requerida en iTerm2:"
  echo "  iTerm2 → Settings → Profiles → Text"
  echo "  Font: $FONT_NAME"
  echo "  (Marcar: Use a different font for non-ASCII text)"
fi
