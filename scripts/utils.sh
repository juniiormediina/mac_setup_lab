#!/usr/bin/env bash

# =========================================
# utils.sh
# Utilidades compartidas para logging,
# validación, ejecución segura y helpers.
# =========================================

set -u

readonly APPLE_SILICON_BREW_BIN="/opt/homebrew/bin/brew"
readonly INTEL_BREW_BIN="/usr/local/bin/brew"
readonly PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
readonly LOG_DIR="$PROJECT_ROOT/logs"

LOG_FILE=""

print_blank() {
  echo
}

print_line() {
  printf '%*s\n' "${COLUMNS:-80}" '' | tr ' ' '='
}

print_header() {
  print_blank
  print_line
  echo "$1"
  print_line
}

print_subheader() {
  print_blank
  echo "▶ $1"
}

print_step() {
  echo "  → $1"
}

timestamp() {
  date +"%Y-%m-%d %H:%M:%S"
}

init_logs() {
  mkdir -p "$LOG_DIR"
  LOG_FILE="$LOG_DIR/run_$(date +%Y%m%d_%H%M%S).log"
  touch "$LOG_FILE"
}

write_log() {
  local level="$1"
  local message="$2"
  if [[ -n "$LOG_FILE" ]]; then
    echo "[$(timestamp)] [$level] $message" >> "$LOG_FILE"
  fi
}

log_info() {
  echo "  [INFO] $1"
  write_log "INFO" "$1"
}

log_success() {
  echo "  [OK]   $1"
  write_log "OK" "$1"
}

log_warn() {
  echo "  [WARN] $1"
  write_log "WARN" "$1"
}

log_error() {
  echo "  [ERROR] $1" >&2
  write_log "ERROR" "$1"
}

abort() {
  log_error "$1"
  exit 1
}

require_macos() {
  [[ "$(uname -s)" == "Darwin" ]] || abort "Este proyecto solo puede ejecutarse en macOS."
}

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

app_bundle_exists() {
  [[ -d "/Applications/$1.app" || -d "$HOME/Applications/$1.app" ]]
}

file_contains_line() {
  local file_path="$1"
  local expected_line="$2"
  [[ -f "$file_path" ]] && grep -Fqs "$expected_line" "$file_path"
}

ensure_line_in_file() {
  local file_path="$1"
  local line="$2"

  touch "$file_path"

  if file_contains_line "$file_path" "$line"; then
    log_info "La línea ya existe en $(basename "$file_path")."
  else
    echo "$line" >> "$file_path"
    log_success "Se agregó configuración persistente en $(basename "$file_path")."
  fi
}

detect_brew_binary() {
  if [[ -x "$APPLE_SILICON_BREW_BIN" ]]; then
    echo "$APPLE_SILICON_BREW_BIN"
  elif [[ -x "$INTEL_BREW_BIN" ]]; then
    echo "$INTEL_BREW_BIN"
  elif command_exists brew; then
    command -v brew
  else
    return 1
  fi
}

load_homebrew_env() {
  local brew_bin
  brew_bin="$(detect_brew_binary)" || return 1
  eval "$("$brew_bin" shellenv)"
}

get_shell_profile() {
  local current_shell
  current_shell="$(basename "${SHELL:-zsh}")"

  case "$current_shell" in
    zsh) echo "$HOME/.zprofile" ;;
    bash)
      if [[ -f "$HOME/.bash_profile" ]]; then
        echo "$HOME/.bash_profile"
      else
        echo "$HOME/.bashrc"
      fi
      ;;
    *) echo "$HOME/.profile" ;;
  esac
}

ensure_homebrew_in_shell() {
  local brew_bin
  local profile_file
  local shellenv_line

  brew_bin="$(detect_brew_binary)" || abort "No se pudo detectar Homebrew."
  profile_file="$(get_shell_profile)"
  shellenv_line="eval \"\$(${brew_bin} shellenv)\""

  print_step "Cargando Homebrew en la sesión actual..."
  eval "$("$brew_bin" shellenv)"
  log_success "Homebrew cargado en la sesión actual."

  print_step "Persistiendo Homebrew para futuras sesiones..."
  ensure_line_in_file "$profile_file" "$shellenv_line"
}

require_homebrew() {
  if ! detect_brew_binary >/dev/null 2>&1 && ! command_exists brew; then
    abort "Homebrew no está disponible. Debes ejecutar primero validate_core.sh."
  fi

  load_homebrew_env || abort "No se pudo cargar Homebrew."
}

brew_formula_installed() {
  brew list --formula "$1" >/dev/null 2>&1
}

brew_cask_installed() {
  brew list --cask "$1" >/dev/null 2>&1
}

create_directory_if_missing() {
  local dir_path="$1"
  local display_name="$2"

  print_subheader "Carpeta: $display_name"

  if [[ -d "$dir_path" ]]; then
    log_info "Ya existe: $dir_path"
    return 0
  fi

  if mkdir -p "$dir_path"; then
    log_success "Creada correctamente: $dir_path"
  else
    abort "No se pudo crear la carpeta: $dir_path"
  fi
}

install_brew_formula_if_missing() {
  local formula_name="$1"
  local display_name="$2"
  local validation_command="${3:-}"

  print_subheader "$display_name"

  if brew_formula_installed "$formula_name"; then
    log_info "$display_name ya está instalado mediante Homebrew."
    return 0
  fi

  if [[ -n "$validation_command" ]] && command_exists "$validation_command"; then
    log_info "$display_name ya está disponible en el sistema."
    return 0
  fi

  print_step "Instalando $display_name..."
  brew install "$formula_name"
  log_success "$display_name instalado correctamente."
}

install_brew_cask_if_missing() {
  local cask_name="$1"
  local display_name="$2"
  local app_name="${3:-}"

  print_subheader "$display_name"

  if brew_cask_installed "$cask_name"; then
    log_info "$display_name ya está instalado mediante Homebrew Cask."
    return 0
  fi

  if [[ -n "$app_name" ]] && app_bundle_exists "$app_name"; then
    log_info "$display_name ya existe en Applications."
    return 0
  fi

  print_step "Instalando $display_name..."
  brew install --cask "$cask_name"
  log_success "$display_name instalado correctamente."
}

run_brew_update() {
  print_step "Actualizando índices de Homebrew..."
  brew update
  log_success "Homebrew actualizado."
}

parse_pipe_record() {
  local record="$1"
  local field_index="$2"
  echo "$record" | awk -F'|' -v idx="$field_index" '{print $idx}'
}

install_package_from_record() {
  local package_type="$1"
  local package_name="$2"
  local display_name="$3"
  local validation_target="$4"

  case "$package_type" in
    cask)
      install_brew_cask_if_missing "$package_name" "$display_name" "$validation_target"
      ;;
    formula)
      install_brew_formula_if_missing "$package_name" "$display_name" "$validation_target"
      ;;
    *)
      abort "Tipo de paquete no soportado: $package_type"
      ;;
  esac
}

show_main_menu() {
  local option

  print_blank
  echo "Selecciona una opción:"
  echo "  1) Solo configuración básica"
  echo "  2) Configuración básica + herramientas de desarrollo"
  print_blank

  read -r -p "Ingresa 1 o 2: " option

  case "$option" in
    1|2) echo "$option" ;;
    *) echo "invalid" ;;
  esac
}
