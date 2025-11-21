#!/bin/bash

# =====================================================
# 🚀 BOOTSTRAP — Instalación & Configuración MacOS
# Orquesta todo el proceso en orden
# =====================================================

print_title() {
    echo ""
    echo "============================================"
    echo " $1"
    echo "============================================"
    echo ""
}

print_step() {
    echo ""
    echo "➡ $1"
    echo ""
}

# =====================================================
# 0. Verificar permisos de ejecución en scripts
# =====================================================
print_title "Verificando permisos de ejecución"

chmod +x setup_base.sh
chmod +x install_basic_apps.sh
chmod +x install_dev_tools.sh

echo "✔ Permisos verificados."

# =====================================================
# 1. Ejecutar Setup Base
# =====================================================
print_title "Paso 1 — Ejecutando Setup Base (Homebrew + Git + Configs)"

print_step "Iniciando setup_base.sh..."
./setup_base.sh

if [[ $? -ne 0 ]]; then
    echo "❌ Error ejecutando setup_base.sh. Abortando bootstrap."
    exit 1
fi

echo "✔ Setup base completado."

# =====================================================
# 2. Instalación de Apps Básicas
# =====================================================
print_title "Paso 2 — Instalando apps básicas"

print_step "Iniciando install_basic_apps.sh..."
./install_basic_apps.sh

if [[ $? -ne 0 ]]; then
    echo "❌ Error ejecutando install_basic_apps.sh. Abortando bootstrap."
    exit 1
fi

echo "✔ Apps básicas instaladas."

# =====================================================
# 3. Instalación de Herramientas de Desarrollo (opcional)
# =====================================================
print_title "Paso 3 — Instalación de herramientas de desarrollo"

print_step "Verificando si se solicitó instalación de herramientas dev..."

# El script setup_base.sh se encarga de preguntar y ejecutar install_dev_tools.sh,
# pero igual validamos que exista y está ejecutable.
if [[ -f "install_dev_tools.sh" ]]; then
    echo "✔ Script de dev tools listo."
else
    echo "⚠ No se encontró install_dev_tools.sh"
fi

echo ""
echo "Si en el Setup Base elegiste instalar herramientas de desarrollo, ya se instalaron."
echo "Si no, puedes ejecutarlo manualmente con:"
echo ""
echo "   ./install_dev_tools.sh"
echo ""

# =====================================================
# 4. Finalización
# =====================================================
print_title "🎉 BOOTSTRAP COMPLETADO"

echo "Tu Mac ahora está configurado con:"
echo "✔ Homebrew"
echo "✔ Git"
echo "✔ Configuraciones del sistema"
echo "✔ Apps básicas"
echo "✔ (Opcional) Herramientas de desarrollo"
echo ""
echo "🚀 Todo listo para trabajar."
echo ""
