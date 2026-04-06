#!/usr/bin/env bash

# =========================================
# validate_core.sh
# Valida e instala Homebrew y Git.
# =========================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./utils.sh
source "$SCRIPT_DIR/utils.sh"

install_homebrew_if_missing() {
  print_header "Validación de Homebrew"

  if detect_brew_binary >/dev/null 2>&1 || command_exists brew; then
    log_info "Homebrew ya está instalado."
    ensure_homebrew_in_shell

    if brew --version >/dev/null 2>&1; then
      log_success "Homebrew está funcionando correctamente."
    else
      abort "Homebrew parece estar instalado, pero no responde."
    fi

    return 0
  fi

  print_step "Homebrew no está instalado."
  print_step "Ejecutando instalador oficial..."

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  ensure_homebrew_in_shell

  if brew --version >/dev/null 2>&1; then
    log_success "Homebrew quedó instalado y operativo."
  else
    abort "Homebrew fue instalado, pero brew no responde."
  fi

  run_brew_update
}

install_git_if_missing() {
  print_header "Validación de Git"

  require_homebrew

  if command_exists git; then
    log_info "Git ya está instalado."
    log_success "Versión detectada: $(git --version)"
    return 0
  fi

  print_step "Git no está instalado."
  print_step "Instalando Git con Homebrew..."
  brew install git

  if command_exists git; then
    log_success "Git instalado correctamente."
    log_success "Versión detectada: $(git --version)"
  else
    abort "Git no quedó disponible después de la instalación."
  fi
}

main() {
  require_macos
  install_homebrew_if_missing
  install_git_if_missing
}

main "$@"
