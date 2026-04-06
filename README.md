# mac_setup_lab

Automatización modular para preparar una nueva máquina macOS de forma ordenada, clara y profesional.

## Objetivo

Este proyecto permite ejecutar una configuración inicial en dos niveles:

1. Configuración y herramientas básicas
2. Herramientas de desarrollo

La solución está diseñada con enfoque modular, mantenible y extensible.

---

## Estructura del proyecto

```text
mac_setup_lab/
├─ README.md
├─ .gitignore
├─ config/
│  └─ packages.conf
├─ logs/
│  └─ .gitkeep
└─ scripts/
   ├─ bootstrap.sh
   ├─ utils.sh
   ├─ validate_core.sh
   ├─ setup_base.sh
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
- instala:
  - Google Chrome
  - Rectangle

### Parte 2: herramientas de desarrollo

Instala, validando previamente si ya existen:

- Visual Studio Code
- WebStorm
- Android Studio
- IntelliJ IDEA Community Edition
- Node.js
- Python
- iTerm2
- Docker Desktop

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

### 5. Ejecutar sin preguntas interactivas

```bash
./scripts/bootstrap.sh --full --yes
```

---

## Logs

Cada ejecución genera un archivo en:

```bash
logs/
```

Esto permite revisar detalles, errores o auditoría del proceso.

---

## Decisiones de diseño

### `bootstrap.sh`
Es el punto de entrada. Orquesta todo el flujo.

### `utils.sh`
Contiene funciones reutilizables:
- logging
- validaciones
- detección de Homebrew
- helpers comunes

### `validate_core.sh`
Responsable de la base mínima del sistema:
- Homebrew
- Git

### `setup_base.sh`
Responsable de:
- crear carpetas
- configurar screenshots

### `install_core.sh`
Instala apps básicas.

### `install_dev.sh`
Instala herramientas de desarrollo.

### `config/packages.conf`
Centraliza la lista de herramientas. Esto facilita crecimiento futuro.

---

## Consideraciones importantes

### Homebrew
La instalación oficial puede pedir contraseña de administrador.

### Apple Silicon
El script contempla correctamente `/opt/homebrew`.

### Docker Desktop
Puede requerir pasos adicionales la primera vez que se abre.

### Visual Studio Code
El script instala la app, pero no habilita automáticamente el comando `code` en PATH.

---

## Futuras mejoras posibles

- soporte para seleccionar paquetes individualmente
- configuración de Git global
- instalación de Java, Flutter o Android SDK variables
- shellcheck en CI
- más validaciones post-instalación
- soporte para dotfiles
