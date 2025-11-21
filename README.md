# mac_setup_lab

<p align="center">
  <img src="assets/banner.svg" width="100%" />
</p>

**Automated macOS setup for productivity & development.**

mac_setup_lab es un conjunto de scripts diseñados para automatizar la instalación, configuración y preparación de un entorno macOS para productividad y desarrollo de software.

La estructura sigue una lógica modular, segura y mantenible: primero se configuran ajustes del sistema, luego se valida la presencia de Homebrew y Git, y finalmente se ejecuta la instalación de herramientas básicas o, si el usuario lo desea, la instalación completa del entorno de desarrollo.

---

## 📁 Estructura del Repositorio

```
mac_setup_lab/
│
├─ assets/
│   └─ banner.svg
│
├─ scripts/
│   ├─ bootstrap.sh              # Script maestro
│   ├─ setup_base.sh             # Configuraciones iniciales macOS
│   ├─ validate_core.sh          # Validación de Homebrew y Git
│   ├─ install_core.sh           # Instalación de apps básicas
│   ├─ install_dev.sh            # Instalación de stack de desarrollo
│   └─ utils.sh                  # Funciones compartidas
│
├─ config/
│   ├─ git-templates/            # Archivos iniciales para configuración de Git
│   └─ docs/                     # Documentación adicional
│
└─ README.md
```

---

## 🚀 Flujo de Instalación

### 1️⃣ Ejecutar el script maestro

El punto de entrada recomendado es:

```bash
./scripts/bootstrap.sh
```

El script:

* Ejecuta configuraciones iniciales del sistema.
* Valida si Homebrew y Git están instalados.
* Si no lo están, los instala previo consentimiento del usuario.
* Crea la carpeta **~/Development** como espacio raíz de trabajo.
* Pregunta si deseas instalar solo herramientas básicas o todo el entorno de desarrollo.

---

## 🧩 Scripts Principales

### 🔧 `setup_base.sh`

Incluye configuraciones iniciales de macOS, como:

* Carpeta de capturas de pantalla
* Ajustes del SystemUIServer
* Estructura de carpetas base

Ejemplo:

```bash
mkdir -p ~/Documents/Screenshots
defaults write com.apple.screencapture location ~/Documents/Screenshots
killall SystemUIServer
```

---

### ✔️ `validate_core.sh`

Verifica que Homebrew y Git estén instalados. Si no lo están, solicita permisos para instalarlos.

Incluye:

* Instalación de Homebrew
* Configuración de shellenv
* Validación e instalación de Git

---

### 🌱 `install_core.sh`

Instala herramientas básicas para cualquier usuario:

* **Google Chrome**
* **Rectangle**
* **Spotify**

Cada instalación sigue este patrón:

* Verificar si ya está instalado
* Preguntar si el usuario desea instalarlo
* Continuar con el siguiente si se rechaza

---

### 🧑‍💻 `install_dev.sh`

Instala herramientas de desarrollo bajo confirmación del usuario:

* Node.js
* Python
* iTerm2
* Docker
* VS Code
* Android Studio
* WebStorm
* IntelliJ IDEA CE

Incluye clonación de repos internos en `~/Development`.

---

## 🗃️ Carpetas creadas automáticamente

Durante la ejecución inicial, se crean:

```
~/Development/
    ├─ configs/
    ├─ templates/
    └─ repos/
```

Aquí podrás:

* Guardar configuraciones personalizadas.
* Clonar repositorios propios desde Git.
* Mantener documentación del entorno.

---

## 🧪 Modo de Pruebas

Puedes ejecutar cada script de forma independiente para debugging:

```bash
bash scripts/setup_base.sh
bash scripts/validate_core.sh
bash scripts/install_core.sh
bash scripts/install_dev.sh
```

---

## 🧰 Requisitos

* macOS Ventura o superior
* Usuario con permisos de administrador

---

## 📝 Notas finales

Este proyecto está diseñado para ser modular, seguro y fácil de modificar. La meta es tener un entorno reproducible que puedas ejecutar al cambiar de equipo o reinstalar macOS.
