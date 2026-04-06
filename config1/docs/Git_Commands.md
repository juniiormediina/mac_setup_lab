## **$ git config**

Se usa para configurar GIT por primera vez. Se debe hacer una única vez y se puede actualizar en cualquier momento usando los comandos correctos.
Establecer nombre de usuario y dirección de correo electrónico es importante porque los commits de Git usan esta información y es introducida en los commits que se envían.
- $ git config --global user.name _"Tu nombre"_
- $ git config --global user.email _"Tu correo"_
- $ git config --list -> _Para comprobar las configuraciones._

Tener en cuenta que es muy importante que la configuración de GIT debe ser con el correo banco y no correos personales o de proveedor.

## **$ git status**
Ver el estado de los archivos del proyecto.
## **$ git add**
Se decide que archivos están listos para el siguiente paso y se registran los cambios
añadiéndolos al Staging Area.
- $ git add <file name> -> _añade archivos especificos_
- $ git add . ->_Añade todos los archivos._

## **$ git commit -m "Mensaje”**
Guardar cambios con un mensaje para identificarlos.
Los cambios quedan en el Local Repository, aún no están en el repositorio remoto.

## **$ git push origin < nombre_rama >**
Envía nuestros cambios (commits) al repositorio remoto.

## **$ git remote**
Para ver los repositorios que hay configurados

## **$ git remote add origin <url>**
Vincula nuestro proyecto local, con nuestro proyecto remoto.

## **$ git checkout**
Con este comando viajamos a través de nuestras ramas o commits.
- $ git checkout <nombre_rama> -> Cambiar de rama.
- $ git checkout <id_commit> ->Permite ver el estado del proyecto en
el commimt indicado.

## **$ git branch**
Este comando se usa para listar ramas.
- $ git checkout –b <nombre_rama> ->Crea una rama
- $ git branch –d <nombre_rama> -> Elimina una rama

## **$ git push origin <nombre_rama>**
Una rama no estará disponible para las otras personas a menos que se suba la
rama al repositorio remoto

## **$ git pull**
Actualiza el repositorio local al commit más nuevo.
Actualiza rama actual con los cambios en origin
- Este comando ejecuta un fetch con los argumentos dados, y después
realiza un merge en la rama actual con los datos descargados.

## **$ git reset**
Es similar a checkout a diferencia que este elimina los commits.

- $ git reset –soft
El git reset más simple y que no toca nuestro "Working Area" (No se
mete con nuestro código).

- $ git reset –mixed
Este git reset borra el "Staging Area", sin tocar el "Working Area".

- $ git reset –hard
Este git reset borra absolutamente todo lo que hay en el commit.

## **$ git fetch**
Actualiza las referencias remotas. Localiza en que servidor está el origen
Recupera cualquier dato presente en el servidor que no se tenga localmente y
actualiza la base de datos local moviendo la rama origin/master para que apunte a
la nueva y más reciente posición.

## **$ git clone <url>**
Crea una copia local del repositorio.

## **$ git pull <nombre_del_remote>**
Si la rama actual es una tracking branch: El comando git pull [nombre_del_remote],
actualiza la rama actual con los cambios realizados en la rama asociada del
repositorio remoto.

## **$ git tag -a v1.0 -m 'Mensaje' 612d406**
Los tags (etiquetas) se crean para cada nueva versión publicada de un software.
612d406 se refiere a los caracteres del commit id al cual se quiere referir la
etiqueta. Se puede usar menos caracteres que el commit id, pero debe ser un
numero único.

## **$ git log**
Lista todos los commits con su respectiva información. De este comando se puede
obtener el commit id para la creación del tag.

**ERROR SSL**
git config --global http.sslVerify false 

## **$ git help**
Este comando nos ayuda a saber cómo funciona git o alguno de sus comandos.


# Uso del Comando `git rm -r --cached .`

El comando:

```bash
git rm -r --cached .
```

se utiliza en Git para eliminar archivos del índice (staging area) sin eliminarlos del sistema de archivos local.

Desglose del Comando
git rm: Elimina archivos del índice de Git.
-r: Aplica la eliminación de forma recursiva en directorios.
--cached: Elimina los archivos solo del índice, no del disco.
.: Indica que se aplique a todos los archivos y carpetas en el directorio actual.

¿Cuándo se usa?
Este comando es útil cuando:

Has añadido un archivo .gitignore después de que ciertos archivos ya estaban siendo rastreados por Git.
Quieres que Git deje de rastrear esos archivos sin eliminarlos de tu proyecto local.

Ejemplo de Flujo de Trabajo

# 1. Crear o editar el archivo .gitignore
echo "node_modules/" >> .gitignore

# 2. Eliminar todos los archivos del índice (respetando .gitignore)
git rm -r --cached .

# 3. Volver a añadir todos los archivos (ahora ignorando los que están en .gitignore)
git add .

# 4. Hacer commit de los cambios
git commit -m "Dejar de rastrear archivos listados en .gitignore"

Resultado
Después de ejecutar este flujo:

Git dejará de rastrear los archivos listados en .gitignore.
Los archivos seguirán existiendo en tu sistema local.
El repositorio estará limpio y alineado con las reglas de .gitignore.

Si quieres asegurarte de que tu copia local de una rama (por ejemplo, main) esté exactamente igual que la rama principal en el remoto (por ejemplo, origin/main), puedes usar el siguiente comando de Git:


Explicación:
git fetch origin: Trae los últimos cambios del repositorio remoto sin mezclarlos con tu rama actual.
git reset --hard origin/main: Fuerza tu rama actual a coincidir exactamente con la rama main del remoto (origin/main), descartando cualquier cambio local.
⚠️ Advertencia: Este comando eliminará todos los cambios locales no confirmados (y también los commits locales que no estén en el remoto). Asegúrate de que no necesitas esos cambios antes de ejecutarlo.