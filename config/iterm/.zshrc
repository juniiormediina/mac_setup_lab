# ─────────────────────────────────────────────────────────────
#  Powerlevel10k Instant Prompt (silenciar advertencias)
# ─────────────────────────────────────────────────────────────
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ─────────────────────────────────────────────────────────────
#  Configuración básica de Oh My Zsh y tema
# ─────────────────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins (agrega zsh-syntax-highlighting si lo tienes instalado)
plugins=(git zsh-autosuggestions)

# Carga Oh My Zsh (intenta evitar salidas a consola aquí)
source "$ZSH/oh-my-zsh.sh"

# ─────────────────────────────────────────────────────────────
#  Opciones de Zsh (rendimiento, historial, UX)
# ─────────────────────────────────────────────────────────────
# Historial más útil
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_DUPS              # No repetir comandos consecutivos
setopt HIST_IGNORE_ALL_DUPS          # Remueve duplicados del historial
setopt HIST_FIND_NO_DUPS             # No mostrar duplicados en búsqueda
setopt INC_APPEND_HISTORY            # Guarda mientras se usa el shell
setopt SHARE_HISTORY                 # Comparte historial entre sesiones

# Calidad de vida
setopt AUTO_CD                       # Escribe un directorio y entra
setopt CORRECT                       # Sugerir correcciones en comandos
setopt GLOB_DOTS                     # Incluir archivos ocultos en glob
setopt EXTENDED_GLOB                 # Glob avanzado
setopt COMPLETE_IN_WORD              # Completar dentro de la palabra

# ─────────────────────────────────────────────────────────────
#  Aliases generales y de navegación
# ─────────────────────────────────────────────────────────────
alias ema='code ~/.zshrc'            # Editar zshrc en VS Code
alias uma='source ~/.zshrc'          # Recargar zshrc

alias ll='ls -la'
alias cl='clear'

# Directorios base
alias downloads='cd "$HOME/Downloads"'
alias documents='cd "$HOME/Documents"'
alias projects='cd "$HOME/Projects"'
alias commands='cd "$HOME/Development/Commands"'

# ─────────────────────────────────────────────────────────────
#  iOS y Android (emuladores y utilidades)
# ─────────────────────────────────────────────────────────────
alias emu_ios='open -a Simulator'
alias emu_list_android='emulator -list-avds'
alias emu_android='emulator -avd s23'

# Build & install APK desde el proyecto actual (ruta relativa)
alias apk_install='flutter build apk --debug && adb install -r ./build/app/outputs/flutter-apk/app-debug.apk'

# ─────────────────────────────────────────────────────────────
#  Flutter, Dart y Firebase
# ─────────────────────────────────────────────────────────────
alias flutter_build='flutter build'
alias flutter_channel='flutter channel'
alias flutter_upgrade='flutter upgrade'
alias flutter_config='flutter config'
alias flutter_devices='flutter devices'

alias flutter_deps='flutter pub deps'
alias flutter_doc='flutter doctor --verbose'

alias flutter_clean='sh "$HOME/Development/Commands/clean.sh"'
alias flutter_run='flutter_clean && flutter run'
alias flutter_test='sh "$HOME/Development/Commands/unit_test.sh"'
alias flutter_coverage='sh "$HOME/Development/Commands/projects_coverage.sh"'

alias flutter_analyze='flutter analyze'
alias flutter_analizer='dart run dart_code_linter:metrics check-unused-code lib'

alias flutter_firebase='adb shell setprop debug.firebase.analytics.app co.com.bancolombia.personas.superapp'
alias flutter_uninstall='adb uninstall com.example.example'

# ─────────────────────────────────────────────────────────────
#  Git (utilitarios)
# ─────────────────────────────────────────────────────────────
alias git_clean='git clean -fdX'
alias git_log='git log --oneline --graph --decorate'
alias git_log_all='git log --oneline --graph --decorate --all'
alias git_abort='git merge --abort'

alias git_stash='git stash'
alias git_stash-p='git stash pop'
alias git_stash-a='git stash apply'
alias git_stash-l='git stash list'

alias gs='git status'
alias gsb='git status -sb'
alias ga='git add '
alias gc='git commit -m'
alias gca='git commit --amend'

alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gbd='git branch -d'

alias git_pull='git pull origin'
alias gpo='git push origin'
alias gpu='git push upstream'
alias gpf='git push --force'

alias gm='git merge'
alias grb='git rebase'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'

alias gd='git diff'
alias gds='git diff --staged'

# ─────────────────────────────────────────────────────────────
#  Kubernetes/Docker
# ─────────────────────────────────────────────────────────────
# Si tienes kubectl en PATH; usa alias corto:
alias k='kubectl'

# ─────────────────────────────────────────────────────────────
#  Rutas y entorno (PATH) — Apple Silicon
# ─────────────────────────────────────────────────────────────
# Homebrew en Apple Silicon (silenciado para evitar warnings en init)
if command -v /opt/homebrew/bin/brew >/dev/null 2>&1; then
  eval "$(/opt/homebrew/bin/brew shellenv)" 2>/dev/null
fi

# Flutter SDK
export PATH="$HOME/Development/flutter/bin:$PATH"

# Android SDK
export ANDROID_HOME="$HOME/Library/Android/sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
export PATH="$ANDROID_HOME/emulator:$PATH"

# Java (usa una sola versión; aquí JDK 21)
export JAVA_HOME="/opt/homebrew/Cellar/openjdk@21/21.0.9/libexec/openjdk.jdk/Contents/Home"
alias java_home='echo $JAVA_HOME'
alias java_version='java --version'
alias java_list='/usr/libexec/java_home -V'

# Dart (pub cache) y locale
export PATH="$HOME/.pub-cache/bin:$PATH"
export LANG="en_US.UTF-8"

# Comandos personales
export PATH="$HOME/Development/Commands:$PATH"

# Deduplicar PATH
typeset -U PATH path

# curl (si necesitas esta versión de Homebrew)
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/curl/lib"
export CPPFLAGS="-I/opt/homebrew/opt/curl/include"

# ─────────────────────────────────────────────────────────────
#  Powerlevel10k (tema)
# ─────────────────────────────────────────────────────────────
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# ─────────────────────────────────────────────────────────────
#  Autocompletados (proteger para sesión interactiva)
# ─────────────────────────────────────────────────────────────
# Dart completion (ya protegido por -f)
[[ -f "$HOME/.dart-cli-completion/zsh-config.zsh" ]] && source "$HOME/.dart-cli-completion/zsh-config.zsh"

# Angular CLI autocompletion (solo si ng existe, y sesión interactiva)
if [[ $- == *i* ]] && command -v ng >/dev/null 2>&1; then
  source <(ng completion script) 2>/dev/null
fi
