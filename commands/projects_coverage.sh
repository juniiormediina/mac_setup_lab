#!/bin/bash
PROJECT_PATH=$(pwd)

if [ ! -d "$PROJECT_PATH" ]; then
  echo "La ruta: [ $PROJECT_PATH ] no existe"
  exit 0
fi

for folder in "$PROJECT_PATH"/*; do
  if [[ -d "$folder" ]]; then
    folder_name=$(basename "$folder")
    if [[ $folder_name == app* ]]; then
     cd "$folder"
     echo "Coverage for: $folder_name"
     flutter test --coverage >/dev/null 2>&1
     lcov --summary coverage/lcov.info | grep 'lines......:' | awk '{print $2}'
     cd - >/dev/null
    fi
  fi
done