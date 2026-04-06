#!/usr/bin/env bash

# =========================================
# move_command_files.sh
# Copia scripts personalizados desde la
# carpeta commands del proyecto hacia
# ~/Commands y asigna permisos de ejecución.
# =========================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SOURCE_DIR="$PROJECT_ROOT/commands"
TARGET_DIR="$HOME/Commands"

# shellcheck source=./utils.sh
source "$SCRIPT_DIR/utils.sh"

copy_command_files() {
  print_header "Copia de comandos personalizados"

  if [[ ! -d "$SOURCE_DIR" ]]; then
    log_warn "No existe la carpeta source de comandos: $SOURCE_DIR"
    return 0
  fi

  create_directory_if_missing "$TARGET_DIR" "Commands"

  local copied_count=0
  local file_path
  local file_name

  shopt -s nullglob
  for file_path in "$SOURCE_DIR"/*; do
    if [[ -f "$file_path" ]]; then
      file_name="$(basename "$file_path")"

      print_step "Copiando $file_name a $TARGET_DIR..."
      cp "$file_path" "$TARGET_DIR/$file_name"

      chmod +x "$TARGET_DIR/$file_name"
      log_success "Copiado y permisos asignados: $TARGET_DIR/$file_name"

      copied_count=$((copied_count + 1))
    fi
  done
  shopt -u nullglob

  if [[ "$copied_count" -eq 0 ]]; then
    log_warn "No se encontraron archivos para copiar en $SOURCE_DIR."
  else
    log_success "Total de comandos copiados: $copied_count"
  fi
}

main() {
  require_macos
  copy_command_files
}

main "$@"
