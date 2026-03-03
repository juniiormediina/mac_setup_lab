# Manual de Configuración SSH para Gestión de Repositorios (macOS)

**Perfiles:**

- GitHub Personal → **Ed25519** (archivo sugerido: `~/.ssh/id_ed25519_github`)
- Azure Enterprise → **RSA o Ed25519** (archivos sugeridos: `~/.ssh/id_rsa_azure` o `~/.ssh/id_ed25519_azure`)

Incluye pasos completos, comandos, diagramas de flujo y una sección para **eliminar/limpiar** claves.

---

## 0) Diagramas de Flujo

**Flujo general del proceso**

![Diagrama Flujo General](diagrama_flujo_general.png)

**Decisión de algoritmo por plataforma**

![Diagrama Decisión Algoritmo](diagrama_decision_algoritmo.png)

---

## 1) Verificar instalaciones

```bash
git --version
ssh -V
```

---

## 2) Generar claves SSH por perfil

> Recomendación actual: **Ed25519** por rendimiento/seguridad modernos. Algunas organizaciones aún exigen **RSA** (Azure admite ambos).

### 2.1 GitHub Personal (Ed25519)

```bash
ssh-keygen -t ed25519 -C "tu-email-personal@example.com" -f ~/.ssh/id_ed25519_github
```

### 2.2 Azure Enterprise

**Opción A — RSA** (común en entornos enterprise):

```bash
ssh-keygen -t rsa -b 4096 -C "tu-email-empresa@example.com" -f ~/.ssh/id_rsa_azure
```

**Opción B — Ed25519** (si tu organización lo permite):

```bash
ssh-keygen -t ed25519 -C "tu-email-empresa@example.com" -f ~/.ssh/id_ed25519_azure
```

---

## 3) Configurar `~/.ssh/config`

Editar/crear archivo:

```bash
nano ~/.ssh/config
```

**GitHub Personal** (Ed25519):

```
Host github-personal
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_github
    IdentitiesOnly yes
```

**Azure Enterprise** (elige la identidad que generaste):

- Si usas **RSA**:

```
Host azure-enterprise
    HostName ssh.dev.azure.com
    User git
    IdentityFile ~/.ssh/id_rsa_azure
    IdentitiesOnly yes
```

- Si usas **Ed25519**:

```
Host azure-enterprise
    HostName ssh.dev.azure.com
    User git
    IdentityFile ~/.ssh/id_ed25519_azure
    IdentitiesOnly yes
```

Permisos recomendados:

```bash
chmod 600 ~/.ssh/config
chmod 600 ~/.ssh/id_* ~/.ssh/id_*.pub
```

---

## 4) Agregar claves al agente SSH (macOS)

Inicia el agente y agrega cada clave que vayas a usar:

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519_github
# Para Azure (según opción elegida)
ssh-add ~/.ssh/id_rsa_azure     # si usaste RSA
ssh-add ~/.ssh/id_ed25519_azure # si usaste Ed25519
```

> Consejo: Si usas **passphrase**, el Llavero de macOS puede gestionar el guardado.

---

## 5) Registrar claves públicas en las plataformas

Obtener la **clave pública** y registrarla:

**GitHub** → _Settings > SSH and GPG Keys_

```bash
cat ~/.ssh/id_ed25519_github.pub
```

**Azure DevOps** → _User Settings > SSH Public Keys_

```bash
# Según el tipo
cat ~/.ssh/id_rsa_azure.pub
# o
cat ~/.ssh/id_ed25519_azure.pub
```

---

## 6) Probar conexión

```bash
ssh -T git@github-personal
ssh -T git@azure-enterprise
```

Deberías ver un mensaje de bienvenida (o confirmación de autenticidad del host en el primer intento).

---

## 7) Clonar y gestionar `origin`

### 7.1 Clonar con cada perfil

**GitHub Personal**

```bash
git clone git@github-personal:USUARIO/REPO.git
```

**Azure Enterprise** (formato SSH típico en Azure DevOps):

```bash
git clone git@azure-enterprise:v3/ORGANIZACION/PROYECTO/REPO
```

### 7.2 Consultar `origin` del proyecto actual

```bash
git remote -v
```

### 7.3 Cambiar `origin` según el perfil

**Usar GitHub Personal**

```bash
git remote set-url origin git@github-personal:USUARIO/REPO.git
```

**Usar Azure Enterprise**

```bash
git remote set-url origin git@azure-enterprise:v3/ORGANIZACION/PROYECTO/REPO
```

---

## 8) (Opcional) Eliminar/limpiar claves

### 8.1 Limpiar todas las identidades cargadas en el agente

```bash
ssh-add -D
```

> Esto **no borra archivos**; solo limpia el agente SSH en memoria.

### 8.2 Borrar claves del disco (⚠️ irreversible)

Primero inspecciona lo que tienes:

```bash
ls ~/.ssh
```

Borrar únicamente Ed25519 por defecto:

```bash
rm ~/.ssh/id_ed25519*
```

Borrar RSA y Ed25519 (privadas y públicas):

```bash
rm ~/.ssh/id_rsa* ~/.ssh/id_ed25519*
```

Borrar todo el contenido de `~/.ssh` (extremo):

```bash
rm -rf ~/.ssh/*
```

### 8.3 Verificar que el agente quedó limpio

```bash
ssh-add -l
# Esperado: The agent has no identities.
```

---

## 9) Notas y buenas prácticas

- Usa nombres de archivo que identifiquen el **perfil** (p. ej., `id_ed25519_github`, `id_rsa_azure`).
- Mantén permisos mínimos en claves y config (`chmod 600`).
- Si cambias de algoritmo para Azure (de RSA a Ed25519), **actualiza** `~/.ssh/config`, vuelve a **ssh-add** y **registra** la nueva clave pública en Azure DevOps.
