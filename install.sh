#!/bin/bash
# install.sh

INSTALL_DIR=$(dirname "$(readlink -f "$0")")
BIN_DIR="$INSTALL_DIR/bin"
ADMIN_SCRIPT="$INSTALL_DIR/admin.sh"

echo "Instalando Admin-CLI desde $INSTALL_DIR..."

SHELL_CFG=""
if [[ "$SHELL" == *"zsh"* ]]; then 
    SHELL_CFG="$HOME/.zshrc"
elif [[ "$SHELL" == *"bash"* ]]; then 
    SHELL_CFG="$HOME/.bashrc"
fi

if [ -z "$SHELL_CFG" ]; then
    echo "No se pudo detectar el archivo de configuración de la shell (bash/zsh)."
    echo "Por favor, añade manualmente:"
    echo "export PATH=\"$BIN_DIR:$PATH\""
    echo "alias admin='$ADMIN_SCRIPT'"
    exit 1
fi

# 1. Añadir bin/ al PATH
if ! grep -q "$BIN_DIR" "$SHELL_CFG"; then
    echo "" >> "$SHELL_CFG"
    echo "# ADMIN-CLI PATH" >> "$SHELL_CFG"
    echo "export PATH=\"$BIN_DIR:$PATH\"" >> "$SHELL_CFG"
    echo "✅ Agregado $BIN_DIR al PATH."
else
    echo "ℹ️  El PATH ya está configurado."
fi

# 2. Alias para admin
if ! grep -q "alias admin=" "$SHELL_CFG"; then
    echo "alias admin='$ADMIN_SCRIPT'" >> "$SHELL_CFG"
    echo "✅ Alias 'admin' creado."
else
    echo "ℹ️  El alias 'admin' ya existe."
fi

# 3. Permisos de ejecución
chmod +x "$ADMIN_SCRIPT"
chmod +x "$BIN_DIR"/*

echo "¡Instalación completa! 🚀"
echo "Ejecuta 'source $SHELL_CFG' o reinicia la terminal para usar:"
echo "  - admin (Menú principal)"
echo "  - cpu, net, procs... (Comandos directos)"
