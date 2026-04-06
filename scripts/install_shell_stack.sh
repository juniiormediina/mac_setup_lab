#!/usr/bin/env bash

# =========================================
# install_shell_stack.sh
# Instala Oh My Zsh, Powerlevel10k y plugins
# de Zsh de forma idempotente.
# =========================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./utils.sh
source "$SCRIPT_DIR/utils.sh"

readonly OH_MY_ZSH_DIR="$HOME/.oh-my-zsh"
readonly ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-$OH_MY_ZSH_DIR/custom}"
readonly P10K_DIR="$ZSH_CUSTOM_DIR/themes/powerlevel10k"
readonly AUTOSUGGESTIONS_DIR="$ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions"
readonly SYNTAX_HIGHLIGHTING_DIR="$ZSH_CUSTOM_DIR/plugins/zsh-syntax-highlighting"

install_oh_my_zsh_if_missing() {
  print_header "Instalación de Oh My Zsh"

  if [[ -d "$OH_MY_ZSH_DIR" ]]; then
    log_info "Oh My Zsh ya está instalado."
    return 0
  fi

  print_step "Instalando Oh My Zsh en modo unattended..."
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

  if [[ -d "$OH_MY_ZSH_DIR" ]]; then
    log_success "Oh My Zsh instalado correctamente."
  else
    abort "Oh My Zsh no quedó instalado correctamente."
  fi
}

install_powerlevel10k_if_missing() {
  print_header "Instalación de Powerlevel10k"

  if [[ -d "$P10K_DIR" ]]; then
    log_info "Powerlevel10k ya está instalado."
    return 0
  fi

  print_step "Clonando Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
  log_success "Powerlevel10k instalado correctamente."
}

install_zsh_autosuggestions_if_missing() {
  print_header "Instalación de zsh-autosuggestions"

  if [[ -d "$AUTOSUGGESTIONS_DIR" ]]; then
    log_info "zsh-autosuggestions ya está instalado."
    return 0
  fi

  print_step "Clonando zsh-autosuggestions..."
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "$AUTOSUGGESTIONS_DIR"
  log_success "zsh-autosuggestions instalado correctamente."
}

install_zsh_syntax_highlighting_if_missing() {
  print_header "Instalación de zsh-syntax-highlighting"

  if [[ -d "$SYNTAX_HIGHLIGHTING_DIR" ]]; then
    log_info "zsh-syntax-highlighting ya está instalado."
    return 0
  fi

  print_step "Clonando zsh-syntax-highlighting..."
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$SYNTAX_HIGHLIGHTING_DIR"
  log_success "zsh-syntax-highlighting instalado correctamente."
}

main() {
  require_macos

  if ! command_exists curl; then
    abort "curl es requerido para instalar Oh My Zsh."
  fi

  if ! command_exists git; then
    abort "git es requerido para instalar Oh My Zsh, Powerlevel10k y plugins."
  fi

  install_oh_my_zsh_if_missing
  install_powerlevel10k_if_missing
  install_zsh_autosuggestions_if_missing
  install_zsh_syntax_highlighting_if_missing
}

main "$@"
