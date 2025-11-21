Descripción:

Cuando se hace uso de los pipelines de build para soluciones Flutter, es necesario realizar la validación del paquete de instalación del framework al momento de preparar la instancia, esto debido a que es fundamental validar la integridad del instalador para prevenir posibles vulnerabilidades.

¿Como realizar el proceso de validación?

Cada release de flutter tiene su propio archivo de validación de integridad, vamos a realizar el proceso con el release stable v3.19.3, para esto nos dirigimos a la pagina oficial de los release de Flutter https://docs.flutter.dev/release/archive

Aqui podemos encontrar el resumen de versiones release lanzadas por el equipo de Flutter.

image.png

Para la versión 3.19.3 que queremos certificar podemos observar que existe una información provenance con nombre "Attestation bundle"

image.png

Al abrirlo encontramos que se trata de un json con la información de integridad de ese release particular.

image.png

Aquí nos interesa de forma particular la llave del json "payload", contiene un JWT con la información del release y el hash de integridad, procedemos a copiarlo para poder decodificarlo.

image.png

Una vez copiado el JWT podemos decodificarlo con alguna herramienta para este fin, para este proceso podemos usar la siguiente herramienta online https://jwt.io/

Pegamos el JWT copiado dentro de la ventana "Encoded" de la herramienta y obtendremos el HASH SHA-256 para este release particular

image.png

Este HASH podemos usarlo para realizar la validación del paquete de instalación dentro de los pipiles de build o dentro del proceso de desarrollo.

¿Como realizar el proceso de validación dentro del pipeline de build?

El proceso consiste en obtener el HASH SHA-256 del archivo descargado dentro del pipeline y compararlo con el obtenido en el proceso de manual referenciado en el paso anterior

Este es un ejemplo de un script sh que puede usarse como referencia, lo que hace es generar el SHA-256 a partir del archivo flutter.zip descargado del repositorio oficial y compararlo con el HASH que obtuvimos directamente de la información de provenance del archivo de releases.

default_version="3.19.3"
version=${1:-$default_version}

echo "\n**** Descargando Flutter [ $version ] ****\n"
curl https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_$version-stable.zip >flutter.zip

expectedHash="61eaa3b6ebc27d00bbe6bb8076240897b7b99979e9553f40a24a739708c97c39"
downloaded_hash=$(shasum -a 256 flutter.zip | awk '{print $1}')

if [ "$expectedHash" != "$downloaded_hash" ]; then
    echo "\n**** La validación de integridad del paquete ha fallado. 🚫 🚫 ****\n"
    exit 1
else
    echo "\n**** Validación de integridad del paquete exitosa. ✅ ✅ ****\n"
fi
Información Relacionada

¿Que es un HASH y porque es tan importante?

Un HASH es el resultado de una función criptográfica y matemática usada muy comúnmente en tareas de validación de integridad de datos.

Características de un hash:

Permiten identificar de manera inequívoca un conjunto particular de datos, esto quiere decir que a la misma entrada siempre tendremos la misma salida alfanumérica (hash)
Son únicos, usando algoritmos de hashing seguros como SHA-256 obtendremos siempre el mismo hash para la misma entrada de datos.
Son unidireccionales, esto quiere decir que a partir de los datos originales es posible generar el hash, pero, no es posible obtener la data original partir de un hash generado.
Los hash son importantes porque nos permiten garantizar la integridad de los datos que se usarán para un determinado proceso, en el caso puntual de los instaladores de Flutter nos garantiza que siempre vamos a usar la versión original lanzada por el equipo de Google y no una posible versión falsa con código corrupto o vulnerabilidades no deseadas.