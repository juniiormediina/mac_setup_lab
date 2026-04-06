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

install_dev_packages() {
  print_header "Instalación de herramientas de desarrollo"

  require_homebrew

  local record
  local package_type
  local package_name
  local display_name
  local validation_target

  for record in "${DEV_PACKAGES[@]}"; do
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

  log_success "Instalación de herramientas de desarrollo completada."
}

main() {
  require_macos
  install_dev_packages
}

main "$@"
