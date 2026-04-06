#!/usr/bin/env bash

# =========================================
# configure_shell.sh
# Configura el entorno de shell copiando
# .zshrc y .p10k.zsh al HOME del usuario.
# =========================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

SOURCE_ZSHRC="$PROJECT_ROOT/config/zshrc"
SOURCE_P10K="$PROJECT_ROOT/config/p10k.zsh"
TARGET_ZSHRC="$HOME/.zshrc"
TARGET_P10K="$HOME/.p10k.zsh"

# shellcheck source=./utils.sh
source "$SCRIPT_DIR/utils.sh"

backup_file_if_exists() {
  local target_file="$1"
  local base_name
  local backup_file

  if [[ -f "$target_file" ]]; then
    base_name="$(basename "$target_file")"
    backup_file="$HOME/${base_name}.backup.$(date +%Y%m%d_%H%M%S)"
    print_step "Creando backup de $base_name en $backup_file"
    cp "$target_file" "$backup_file"
    log_success "Backup creado para $base_name."
  fi
}

copy_dotfile_if_exists() {
  local source_file="$1"
  local target_file="$2"
  local display_name="$3"

  if [[ ! -f "$source_file" ]]; then
    log_warn "No existe archivo source para $display_name: $source_file"
    return 0
  fi

  print_step "Copiando $display_name al HOME..."
  cp "$source_file" "$target_file"
  log_success "$display_name copiado correctamente."
}

main() {
  require_macos

  print_header "Configuración de shell (.zshrc y .p10k.zsh)"

  backup_file_if_exists "$TARGET_ZSHRC"
  copy_dotfile_if_exists "$SOURCE_ZSHRC" "$TARGET_ZSHRC" ".zshrc"

  backup_file_if_exists "$TARGET_P10K"
  copy_dotfile_if_exists "$SOURCE_P10K" "$TARGET_P10K" ".p10k.zsh"

  print_blank
  log_info "Para aplicar cambios ejecuta:"
  echo "  source ~/.zshrc"
}

main "$@"
