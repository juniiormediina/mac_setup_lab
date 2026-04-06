#!/usr/bin/env bash

# =========================================
# install_core.sh
# Instala herramientas básicas.
# =========================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# shellcheck source=./utils.sh
source "$SCRIPT_DIR/utils.sh"
# shellcheck source=../config/packages.conf
source "$PROJECT_ROOT/config/packages.conf"

install_core_packages() {
  print_header "Instalación de herramientas básicas"

  require_homebrew

  local record
  local cask_name
  local display_name
  local app_name

  for record in "${CORE_CASKS[@]}"; do
    cask_name="$(parse_pipe_record "$record" 1)"
    display_name="$(parse_pipe_record "$record" 2)"
    app_name="$(parse_pipe_record "$record" 3)"

    install_brew_cask_if_missing "$cask_name" "$display_name" "$app_name"
  done
}

main() {
  require_macos
  install_core_packages
}

main "$@"
