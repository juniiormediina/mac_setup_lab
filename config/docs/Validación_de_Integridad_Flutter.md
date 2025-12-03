# ✅ Validación de integridad del paquete Flutter en pipelines

---

Cuando se usan pipelines de build para soluciones Flutter, es fundamental validar la integridad del instalador del framework antes de preparar la instancia. Esto previene vulnerabilidades y asegura que el paquete descargado es el original publicado por el equipo de Flutter.

---

**¿Por qué validar la integridad?**

- Garantiza que el instalador no ha sido alterado.
- Previene vulnerabilidades por código malicioso.
- Cumple buenas prácticas de seguridad en CI/CD.

---

## Métodos para obtener el hash SHA-256

Existen dos formas de obtener el hash oficial para la validación:

---

### Opción 1: Desde el Attestation Bundle (Método oficial)

1. Ir a [Flutter Release Archive.](https://docs.flutter.dev/release/archive)
2. Buscar la versión deseada (ej. 3.35.6).
3. Descargar el archivo Attestation bundle.
4. Copiar el valor del campo payload (JWT).
5. Decodificar el JWT en jwt.io y extraer el hash SHA-256 oficial.

---

### Opción 2: Generar el hash localmente desde la terminal

Este método es útil si quieres validar el archivo descargado sin depender del Attestation bundle.

Paso a paso:

1. Descargar el instalador oficial:
```Shell
curl -L https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_3.35.6-stable.zip -o flutter.zip
```
2. Generar el hash SHA-256 del archivo descargado:
```Shell
shasum -a 256 flutter.zip
```
3. Copiar el hash generado:
El resultado será algo como:
```
64e6b722e9ebdf9ccc83ef9253f24a3c0519d103e622aeb0c0e7c7647636f1a5  flutter.zip
```

4. Usar este hash en tu script:
Este valor será tu expectedHash para la validación.

---

¿Cómo realizar la validación dentro del pipeline?

El proceso consiste en:
- Descargar el paquete Flutter desde el repositorio oficial.
- Generar el hash SHA-256 del archivo descargado.
- Compararlo con el hash oficial obtenido del Attestation bundle.

---

✅ Ejemplo de script para macOS/Linux

```shell
#!/bin/bash

default_version="3.35.6"
version=${1:-$default_version}

echo "\n**** Descargando Flutter [ $version ] ****\n"
curl -L https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_$version-stable.zip -o flutter.zip

# Hash oficial del release 3.35.6
expectedHash="64e6b722e9ebdf9ccc83ef9253f24a3c0519d103e622aeb0c0e7c7647636f1a5"
downloaded_hash=$(shasum -a 256 flutter.zip | awk '{print $1}')

if [ "$expectedHash" != "$downloaded_hash" ]; then
    echo "\n**** La validación de integridad del paquete ha fallado. 🚫 🚫 ****\n"
    exit 1
else
    echo "\n**** Validación de integridad del paquete exitosa. ✅ ✅ ****\n"
fi

echo "\n**** Descomprimiendo archivo descargado Flutter [ $version ] ****\n"
unzip -q flutter.zip

echo "\n**** Eliminando archivo descargado flutter.zip ****\n"
rm -f flutter.zip

echo "\n**** Configurando variables de entorno ****\n"
export PATH="$PATH:$(pwd)/flutter/bin"

echo "\n**** Ejecutando flutter doctor ****\n"
flutter doctor
```
---

**¿Qué es un HASH y por qué es importante?**

Un hash es el resultado de una función criptográfica que permite validar la integridad de datos.

Características:

- Único: para la misma entrada, siempre genera el mismo valor.
- Unidireccional: no se puede obtener la data original desde el hash.
- Seguro: usando algoritmos como SHA-256, garantiza que cualquier alteración en el archivo cambia el hash.

En este caso, el hash asegura que el instalador de Flutter no ha sido modificado y proviene del equipo oficial.

---

✅ Beneficios:

- Previene vulnerabilidades.
- Garantiza integridad en CI/CD.
- Cumple buenas prácticas de seguridad.
