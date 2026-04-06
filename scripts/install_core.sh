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
  local package_type
  local package_name
  local display_name
  local validation_target

  for record in "${CORE_PACKAGES[@]}"; do
    package_type="$(parse_pipe_record "$record" 1)"
    package_name="$(parse_pipe_record "$record" 2)"
    display_name="$(parse_pipe_record "$record" 3)"
    validation_target="$(parse_pipe_record "$record" 4)"

    install_package_from_record \
      "$package_type" \
      "$package_name" \
      "$display_name" \
      "$validation_target"
  done
}

main() {
  require_macos
  install_core_packages
}

main "$@"
