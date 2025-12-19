#!/bin/bash

PROJECT_PATH=$(pwd)

if [ ! -d "$PROJECT_PATH" ]; then
  echo "La ruta: [ $PROJECT_PATH ] no existe"
  exit 0
fi

cd $PROJECT_PATH

LCOV_FILE="lcov.info"

echo "\n*** INICIO TEST [ PATH $PROJECT_PATH ] ***"

echo "\n---- Ejecutando los tests ... ----\n"
flutter test --coverage

echo "\n---- Eliminando archivos MOCK ... ----\n"
lcov --remove coverage/lcov.info "*/repository_mock/*" -o coverage/new_lcov.info
LCOV_FILE="new_lcov.info"

echo "\n---- Generando archivos para su visualización ... ----\n"
genhtml -o coverage coverage/$LCOV_FILE

echo "\n---- Abriendo datos para [ PATH $PROJECT_PATH ] ... ----\n"
open coverage/index.html

echo "*** FIN [ PATH $PROJECT_PATH ] ***\n"
