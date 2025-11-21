#!/bin/bash

PROJECT_PATH=$(pwd)

if [ ! -d "$PROJECT_PATH" ]; then
  echo "La ruta: [ $PROJECT_PATH ] no existe"
  exit 0
fi

cd $PROJECT_PATH

echo "\n**** SE LIMPIARÁ EL PROYECTO [ PATH $PROJECT_PATH ] ****\n"
flutter clean

echo "\n---- Se actualizarán las dependencias en [ PATH $PROJECT_PATH ] ----\n"
flutter pub upgrade

echo "\n---- Se instalaran dependencias en [ PATH $PROJECT_PATH ] ----\n"
flutter pub get

echo "\n**** FIN[ $PROJECT_PATH ] ****\n"