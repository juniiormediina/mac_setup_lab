# mac_setup_lab

Automatización modular para preparar una nueva máquina macOS de forma ordenada, clara y profesional.

## Objetivo

Este proyecto permite ejecutar una configuración inicial en dos niveles:

1. Configuración y herramientas básicas
2. Herramientas de desarrollo

Además instala y configura automáticamente la base de shell del usuario con Oh My Zsh, Powerlevel10k, plugins y prompt personalizado.

---

## Estructura del proyecto

```text
mac_setup_lab/
├─ README.md
├─ .gitignore
├─ commands/
│  ├─ androidstudio
│  ├─ intellij
│  ├─ webstorm
│  ├─ clean.sh
│  └─ unit_test.sh
├─ config/
│  ├─ packages.conf
│  ├─ zshrc
│  └─ p10k.zsh
├─ logs/
│  └─ .gitkeep
└─ scripts/
   ├─ bootstrap.sh
   ├─ utils.sh
   ├─ validate_core.sh
   ├─ setup_base.sh
   ├─ move_command_files.sh
   ├─ install_shell_stack.sh
   ├─ configure_shell.sh
   ├─ install_core.sh
   └─ install_dev.sh
```

---

## Qué hace

### Parte 1: configuración y herramientas básicas

- valida e instala Homebrew
- valida e instala Git
- crea las carpetas:
  - ~/Projects
  - ~/Development
  - ~/Commands
- crea y configura:
  - ~/Documents/Screenshots
- copia scripts desde `commands/` hacia `~/Commands`
- instala:
  - Oh My Zsh
  - Powerlevel10k
  - zsh-autosuggestions
  - zsh-syntax-highlighting
  - Google Chrome
  - Rectangle
- copia `config/zshrc` hacia `~/.zshrc` haciendo backup si ya existe
- copia `config/p10k.zsh` hacia `~/.p10k.zsh` haciendo backup si ya existe

### Parte 2: herramientas de desarrollo

Instala, validando previamente si ya existen:

- Visual Studio Code
- WebStorm
- Android Studio
- IntelliJ IDEA
- Node.js
- Python
- iTerm2
- Docker Desktop

---

## Estructura de `config/packages.conf`

Formato de cada registro:

```bash
tipo|nombre_brew|nombre_visible|valor_validacion
```

Ejemplos:

```bash
"cask|google-chrome|Google Chrome|Google Chrome"
"formula|node|Node.js|node"
```

- `tipo`: `cask` o `formula`
- `nombre_brew`: nombre del paquete en Homebrew
- `nombre_visible`: texto que se muestra en consola
- `valor_validacion`:
  - para `cask`: nombre de la app esperada en `/Applications`
  - para `formula`: comando a validar con `command -v`

---

## Requisitos

- macOS
- conexión a internet
- permisos de administrador
- bash disponible en el sistema

---

## Cómo usar

### 1. Dar permisos de ejecución

```bash
chmod +x scripts/*.sh
```

### 2. Ejecutar modo interactivo

```bash
./scripts/bootstrap.sh
```

### 3. Ejecutar solo parte básica

```bash
./scripts/bootstrap.sh --basic
```

### 4. Ejecutar parte básica + desarrollo

```bash
./scripts/bootstrap.sh --full
```

---

## Logs

Cada ejecución genera un archivo en:

```bash
logs/
```

---

## Consideraciones importantes

- `install_shell_stack.sh` instala Oh My Zsh en modo unattended.
- `configure_shell.sh` hace backup del `.zshrc` y del `.p10k.zsh` existentes antes de reemplazarlos.
- `zsh-syntax-highlighting` debe quedar como último plugin cargado en `.zshrc`.
- `config/p10k.zsh` versiona la apariencia del prompt de Powerlevel10k para que quede consistente en cualquier Mac nueva.
- iTerm2 no crea automáticamente `~/.zshrc`; el archivo lo crea o copia este proyecto.
