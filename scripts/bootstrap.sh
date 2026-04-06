#!/usr/bin/env bash

# =========================================
# bootstrap.sh
# Script maestro de automatización macOS.
# =========================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=./utils.sh
source "$SCRIPT_DIR/utils.sh"

MODE=""
NON_INTERACTIVE="false"

show_help() {
  cat <<EOF2
Uso:
  ./scripts/bootstrap.sh

Opciones:
  --basic              Ejecuta solo configuración básica
  --full               Ejecuta configuración básica + desarrollo
  --yes                Modo no interactivo
  --help               Muestra esta ayuda

Ejemplos:
  ./scripts/bootstrap.sh
  ./scripts/bootstrap.sh --basic
  ./scripts/bootstrap.sh --full
  ./scripts/bootstrap.sh --full --yes
EOF2
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --basic)
        MODE="basic"
        shift
        ;;
      --full)
        MODE="full"
        shift
        ;;
      --yes)
        NON_INTERACTIVE="true"
        shift
        ;;
      --help|-h)
        show_help
        exit 0
        ;;
      *)
        abort "Argumento no reconocido: $1"
        ;;
    esac
  done
}

show_welcome() {
  clear || true

  print_header "Configuración inicial macOS"

  echo "Este proceso prepara una nueva Mac de forma ordenada, clara y profesional."
  echo
  echo "Incluye:"
  echo "  - validación e instalación de herramientas base"
  echo "  - creación de carpetas principales"
  echo "  - configuración de screenshots"
  echo "  - instalación opcional de herramientas de desarrollo"
  echo
  echo "Se generará un log de ejecución en la carpeta logs/."
  echo
}

run_basic_setup() {
  print_header "Fase 1: configuración y herramientas básicas"

  bash "$SCRIPT_DIR/validate_core.sh"
  bash "$SCRIPT_DIR/setup_base.sh"
  bash "$SCRIPT_DIR/install_core.sh"

  log_success "Fase básica completada."
}

run_dev_setup() {
  print_header "Fase 2: herramientas de desarrollo"

  bash "$SCRIPT_DIR/install_dev.sh"

  log_success "Fase de desarrollo completada."
}

resolve_mode_interactively() {
  local selected_option

  selected_option="$(show_main_menu)"

  case "$selected_option" in
    1) MODE="basic" ;;
    2) MODE="full" ;;
    *) abort "Opción inválida. Debes seleccionar 1 o 2." ;;
  esac
}

main() {
  require_macos
  init_logs
  parse_args "$@"

  show_welcome

  if [[ -z "$MODE" ]]; then
    if [[ "$NON_INTERACTIVE" == "true" ]]; then
      abort "En modo no interactivo debes indicar --basic o --full."
    fi
    resolve_mode_interactively
  fi

  log_info "Archivo de log: $LOG_FILE"
  log_info "Modo seleccionado: $MODE"
  log_info "Modo no interactivo: $NON_INTERACTIVE"

  case "$MODE" in
    basic)
      run_basic_setup
      ;;
    full)
      run_basic_setup
      run_dev_setup
      ;;
    *)
      abort "Modo inválido: $MODE"
      ;;
  esac

  print_header "Proceso finalizado"
  log_success "La automatización terminó correctamente."
  log_info "Revisa el log si deseas más detalle: $LOG_FILE"
}

main "$@"
