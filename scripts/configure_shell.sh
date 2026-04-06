#!/usr/bin/env bash

# =========================================
# configure_shell.sh
# Configura el entorno de shell (zshrc)
# =========================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

SOURCE_ZSHRC="$PROJECT_ROOT/config/zshrc"
TARGET_ZSHRC="$HOME/.zshrc"

# shellcheck source=./utils.sh
source "$SCRIPT_DIR/utils.sh"

backup_existing_zshrc() {
  if [[ -f "$TARGET_ZSHRC" ]]; then
    local backup_file="$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
    print_step "Creando backup de .zshrc en $backup_file"
    cp "$TARGET_ZSHRC" "$backup_file"
    log_success "Backup creado."
  fi
}

copy_zshrc() {
  print_step "Copiando zshrc al HOME..."

  if [[ ! -f "$SOURCE_ZSHRC" ]]; then
    log_warn "No existe archivo source: $SOURCE_ZSHRC"
    return 0
  fi

  cp "$SOURCE_ZSHRC" "$TARGET_ZSHRC"
  log_success ".zshrc copiado correctamente."
}

main() {
  require_macos

  print_header "Configuración de shell (zshrc)"

  backup_existing_zshrc
  copy_zshrc

  print_blank
  log_info "Para aplicar cambios ejecuta:"
  echo "  source ~/.zshrc"
}

main "$@"
