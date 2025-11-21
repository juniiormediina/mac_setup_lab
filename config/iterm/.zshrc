# ===========================
# Custom configuration
# ===========================

# ---------------------------
# Genenral Aliases
# ---------------------------
alias ema='code ~/.zshrc'
alias uma='source ~/.zshrc'

username='junmedin' # Change this to your username

alias ll='ls -la' # List all files in long format
alias cl='clear'

# Default directories
# ---------------------------
alias downloads='cd /Users/${username}/Downloads'
alias documents='cd /Users/${username}/Documents'

# Projects directories
# ---------------------------
alias projects='cd /Users/${username}/Projects'
alias commands='cd /Users/${username}/Commands'

alias Tu360Compras='cd /Users/${username}/Projects/Tu360Compras'
alias modulo='cd /Users/${username}/Projects/Modulo'
alias app_folder='cd /Users/${username}/Projects/APP'

alias offers='cd /Users/${username}/Projects/APP/NU0143001_APP_Tu360Compras_Front_Widgets_MR/widget_offers'

alias app='cd /Users/${username}/Projects/APP/NU0621001_Super_App_Personas_Front_MR/app'
alias app_home='/Users/${username}/Projects/APP/NU0621001_Super_App_Personas_Front_MR/app_home'
alias app_product='/Users/${username}/Projects/APP/NU0621001_Super_App_Personas_Front_MR/app_product'

alias showcase='/Users/${username}/Projects/APP/NU0066001_BDS_MOBILE_MR/showcase'

alias app_core='cd /Users/${username}/Projects/APP/NU0621001_Super_App_Personas_Front_Widgets_MR/commons/app_core'
alias home_dashboard='cd /Users/${username}/Projects/APP/NU0621001_Super_App_Personas_Front_Widgets_MR/commons/home_dashboard'

alias lambdas='cd /Users/${username}/Projects/Tu360Compras/NU0143001_Tu360Compras_Lambdas_MR'
alias cognito_email='cd /Users/${username}/Projects/Tu360Compras/NU0143001_Tu360Compras_Lambdas_MR/ms_cognito_email'
alias offers_lz='cd /Users/${username}/Projects/Tu360Compras/NU0143001_Tu360Compras_Lambdas_MR/ms_offers_lz'
alias offers_update_state='cd /Users/${username}/Projects/Tu360Compras/NU0143001_Tu360Compras_Lambdas_MR/ms_offers_update_state'

# Ios and Android Emulators
# ---------------------------
alias emu_ios='open -a Simulator' # Open iOS emulator
alias emu_list_android='emulator -list-avds' # List all Android emulators
alias emu_android='emulator -avd Pixel_5_API_34' # Open Android emulator
alias apk_install='flutter build apk --debug && adb install -r /build/app/outputs/flutter-apk/app-debug.apk' # Build and install APK

# Flutter commands
# ---------------------------
alias flutter_build='flutter build'
alias flutter_channel='flutter channel'
alias flutter_upgrade='flutter upgrade'
alias flutter_config='flutter config'
alias flutter_devices='flutter devices'

alias flutter_deps='flutter pub deps'
# alias flutter_clean='flutter clean && flutter pub get && flutter pub upgrade'
alias flutter_clean='sh /Users/${username}/Commands/clean.sh'
alias flutter_run='flutter_clean && flutter run'
alias flutter_test='sh /Users/${username}/Commands/unit_test.sh'
alias flutter_coverage='sh /Users/${username}/Commands/projects_coverage.sh'

alias flutter_analyze='flutter analyze'
alias flutter_analizer='dart run dart_code_linter:metrics check-unused-code lib'

alias flutter_firebase='adb shell setprop debug.firebase.analytics.app co.com.bancolombia.personas.superapp'

# Useful Git Aliases
# ---------------------------
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

alias gp='git pull'
alias gpo='git push origin'
alias gpu='git push upstream'
alias gpf='git push --force'

alias gm='git merge'
alias grb='git rebase'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'

alias gd='git diff'
alias gds='git diff --staged'

# Docker commands
# ---------------------------
alias k='./kubectl'

# ===========================
# Path variables configuration
# ===========================

# Flutter SDK
# ---------------------------
export PATH=$HOME/Development/flutter/bin:$PATH # Add Flutter SDK to PATH variable to run flutter commands

# Android SDK
# ---------------------------
export ANDROID_HOME="$HOME/Library/Android/sdk" # Add Android SDK to PATH variable to run android commands
export PATH="$ANDROID_HOME/platform-tools:$PATH" # Add platform-tools to PATH variable to run adb commands
export PATH="$ANDROID_HOME/emulator:$PATH" # Add emulator to PATH variable to run emulator commands

# JAVA_HOME
# ---------------------------
export JAVA_HOME=/Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home # Add JAVA_HOME variable to run java commands

# Dart SDK
# ---------------------------
export PATH="$PATH":"$HOME/.pub-cache/bin" # Add pub cache to PATH variable to run dart commands
export LANG=en_US.UTF-8 # Add LANG variable to avoid issues with flutter commands

# ===========================
# End of Custom configuration
# ===========================