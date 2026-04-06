# 🧰 Configuración de Terminal con Oh My Zsh + Powerlevel10k

Guía paso a paso para personalizar tu terminal usando `brew`, `git`, `oh-my-zsh`, `powerlevel10k` y una fuente recomendada para una mejor apariencia.

---

## ✅ Paso 1: Instalar Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

---

## ✅ Paso 2: Instalar Git

```bash
brew install git
```

---

## ✅ Paso 3: Instalar Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

---

## ✅ Paso 4: Instalar Powerlevel10k

Repositorio oficial: [romkatv/powerlevel10k](https://github.com/romkatv/powerlevel10k)

```bash
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
```

---

## ✅ Paso 5: Instalar fuentes recomendadas (opcional pero muy recomendado)

Instala las siguientes fuentes MesloLGS NF:

- [MesloLGS NF Regular.ttf](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf)
- [MesloLGS NF Bold.ttf](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf)
- [MesloLGS NF Italic.ttf](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf)
- [MesloLGS NF Bold Italic.ttf](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf)

Una vez descargadas, **haz doble clic en cada una para instalarlas** en tu sistema.

---

## ✅ Paso 6: Configurar Powerlevel10k como tema

Edita tu archivo `~/.zshrc`:

```bash
nano ~/zshrc
```

Busca la línea con `ZSH_THEME` y reemplázala por:

```bash
ZSH_THEME="powerlevel10k/powerlevel10k"
```

Guarda y cierra el archivo. Luego reinicia tu terminal.

---

## ✅ Paso 7: Configurar iTerm2 y aplicar la fuente MesloLGS NF

### Opción rápida:

Escribe en la terminal:

```bash
p10k configure
```

Cuando te pregunte si deseas instalar la fuente Meslo Nerd, responde **Yes**.

### Opción manual:

1. Abre iTerm2 → **Preferences**.
2. Ve a **Profiles → Text**.
3. Cambia la fuente a: `MesloLGS NF`.

---

## ✅ Paso 8: Crear nuevo perfil en la Terminal

1. Abre Terminal → **Settings**.
2. Ve a la sección **Profiles**.
3. Crea un nuevo perfil y asígnale un nombre.
4. Elimina el perfil anterior si lo deseas.

---

## ✅ Paso 9: Aplicar esquema de colores personalizado

1. Descarga el esquema de color:  
   👉 `juniiormediina.itermcolors`

2. Abre iTerm2 → Preferences → **Profiles → Colors**.
3. En la opción **Color Presets**, elige **Import** y selecciona el archivo descargado.
4. Vuelve a **Color Presets** y selecciónalo para aplicarlo.

---

## ✅ Paso 10: Configuración en IDEs (VSCode, etc.)

Para una correcta visualización en terminales integradas, asegúrate de usar la fuente `MesloLGS NF`.

### En Visual Studio Code:

1. Abre la configuración (`Cmd + ,`).
2. Busca:
   ```json
   terminal.integrated.fontFamily
   ```
3. Establece su valor como:

```json
"terminal.integrated.fontFamily": "MesloLGS NF"
```

---

## ✅ Paso 11: Configurar Powerlevel10k a tu gusto

En cualquier momento, puedes correr:

```bash
p10k configure
```

Esto abrirá el asistente de configuración donde puedes personalizar tu prompt.

---

## 🔁 Último paso: Reiniciar la terminal

Cierra y vuelve a abrir tu terminal para que se apliquen todos los cambios.

¡Listo! 🎉 Ahora tienes una terminal con un prompt potente y visualmente agradable.
