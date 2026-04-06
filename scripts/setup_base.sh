#!/usr/bin/env bash

# =========================================
# setup_base.sh
# Crea carpetas base y configura screenshots.
# =========================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./utils.sh
source "$SCRIPT_DIR/utils.sh"

create_base_directories() {
  print_header "Creación de carpetas base"

  create_directory_if_missing "$HOME/Projects" "Projects"
  create_directory_if_missing "$HOME/Development" "Development"
  create_directory_if_missing "$HOME/Commands" "Commands"
}

configure_screenshots_location() {
  local screenshots_dir="$HOME/Documents/Screenshots"

  print_header "Configuración de screenshots"

  create_directory_if_missing "$screenshots_dir" "Documents/Screenshots"

  print_step "Configurando ubicación de capturas..."
  defaults write com.apple.screencapture location "$screenshots_dir"

  print_step "Reiniciando SystemUIServer..."
  killall SystemUIServer >/dev/null 2>&1 || true

  log_success "Las capturas se guardarán en: $screenshots_dir"
}

main() {
  require_macos
  create_base_directories
  configure_screenshots_location
}

main "$@"
