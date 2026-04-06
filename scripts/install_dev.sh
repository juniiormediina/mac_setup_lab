#!/usr/bin/env bash

# =========================================
# install_dev.sh
# Instala herramientas de desarrollo.
# =========================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# shellcheck source=./utils.sh
source "$SCRIPT_DIR/utils.sh"
# shellcheck source=../config/packages.conf
source "$PROJECT_ROOT/config/packages.conf"

install_dev_casks() {
  local record
  local cask_name
  local display_name
  local app_name

  for record in "${DEV_CASKS[@]}"; do
    cask_name="$(parse_pipe_record "$record" 1)"
    display_name="$(parse_pipe_record "$record" 2)"
    app_name="$(parse_pipe_record "$record" 3)"

    install_brew_cask_if_missing "$cask_name" "$display_name" "$app_name"
  done
}

install_dev_formulas() {
  local record
  local formula_name
  local display_name
  local validation_command

  for record in "${DEV_FORMULAS[@]}"; do
    formula_name="$(parse_pipe_record "$record" 1)"
    display_name="$(parse_pipe_record "$record" 2)"
    validation_command="$(parse_pipe_record "$record" 3)"

    install_brew_formula_if_missing "$formula_name" "$display_name" "$validation_command"
  done
}

main() {
  require_macos
  require_homebrew

  print_header "Instalación de herramientas de desarrollo"

  install_dev_casks
  install_dev_formulas

  log_success "Instalación de herramientas de desarrollo completada."
}

main "$@"
