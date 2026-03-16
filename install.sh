#!/bin/bash
# ============================================================================
# Admin-CLI Installer
#
# Instalacion online:
#   curl -sL https://raw.githubusercontent.com/Debaq/admin-cli-archlinux/main/install.sh | bash
#
# Desde repo clonado:
#   ./install.sh
#
# Actualizar:
#   admin-update
# ============================================================================

REPO_URL="https://github.com/Debaq/admin-cli-archlinux.git"
INSTALL_DIR="$HOME/.admin-cli"

GREEN="\033[32m"
YELLOW="\033[33m"
CYAN="\033[36m"
RED="\033[31m"
BOLD="\033[1m"
NC="\033[0m"

# ── Detectar shell config ──
SHELL_CFG=""
if [[ "$SHELL" == *"zsh"* ]]; then
    SHELL_CFG="$HOME/.zshrc"
elif [[ "$SHELL" == *"bash"* ]]; then
    SHELL_CFG="$HOME/.bashrc"
fi

if [ -z "$SHELL_CFG" ]; then
    echo -e "${RED}No se detectó bash ni zsh.${NC}"
    echo "Agrega manualmente a tu shell:"
    echo "  export PATH=\"$INSTALL_DIR/bin:\$PATH\""
    echo "  alias admin='$INSTALL_DIR/admin.sh'"
    exit 1
fi

IS_UPDATE=false

echo -e ""
echo -e "${BOLD}${CYAN}  ADMIN-CLI Installer${NC}"
echo -e "${CYAN}  ─────────────────────────────────${NC}"
echo -e ""

# ── 1. Clonar o actualizar el repo ──
if [ -d "$INSTALL_DIR/.git" ]; then
    IS_UPDATE=true
    echo -e "${BOLD}[1/2]${NC} Actualizando desde GitHub..."
    cd "$INSTALL_DIR"
    git pull --ff-only 2>&1 | while read -r line; do
        echo -e "  ${CYAN}$line${NC}"
    done
else
    echo -e "${BOLD}[1/3]${NC} Clonando repositorio..."

    # Si estamos dentro de un repo clonado, mover en vez de re-clonar
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
    if [ -f "$SCRIPT_DIR/admin.sh" ] && [ -d "$SCRIPT_DIR/bin" ]; then
        if [ "$SCRIPT_DIR" != "$INSTALL_DIR" ]; then
            echo -e "  Moviendo desde ${CYAN}$SCRIPT_DIR${NC}"
            # Copiar todo al destino
            mkdir -p "$INSTALL_DIR"
            cp -a "$SCRIPT_DIR/." "$INSTALL_DIR/"
        else
            echo -e "  ${GREEN}Ya está en la ubicación correcta.${NC}"
        fi
    else
        # Instalación online: clonar
        if ! command -v git &>/dev/null; then
            echo -e "${RED}Error: git no está instalado.${NC}"
            echo "Instala con: sudo pacman -S git"
            exit 1
        fi
        git clone "$REPO_URL" "$INSTALL_DIR" 2>&1 | while read -r line; do
            echo -e "  ${CYAN}$line${NC}"
        done
    fi
fi

# ── 2. Permisos ──
if [ "$IS_UPDATE" = true ]; then
    echo -e "${BOLD}[2/2]${NC} Configurando permisos..."
else
    echo -e "${BOLD}[2/3]${NC} Configurando permisos..."
fi
chmod +x "$INSTALL_DIR/admin.sh"
chmod +x "$INSTALL_DIR/bin/"*

# ── 3. Configurar shell (solo en instalación nueva o si el bloque está roto) ──
SHELL_BLOCK_OK=false
if grep -q '# ADMIN-CLI' "$SHELL_CFG" 2>/dev/null && \
   grep -q '\.admin-cli/bin' "$SHELL_CFG" 2>/dev/null && \
   grep -q 'alias admin=' "$SHELL_CFG" 2>/dev/null && \
   grep -q 'alias admin-update=' "$SHELL_CFG" 2>/dev/null; then
    SHELL_BLOCK_OK=true
fi

if [ "$SHELL_BLOCK_OK" = true ]; then
    if [ "$IS_UPDATE" = false ]; then
        echo -e "${BOLD}[3/3]${NC} Shell ya configurado ${GREEN}✓${NC}"
    fi
else
    echo -e "${BOLD}[3/3]${NC} Configurando $SHELL_CFG..."

    # Limpiar instalaciones previas (rutas viejas)
    if grep -q "ADMIN-CLI" "$SHELL_CFG" 2>/dev/null; then
        sed -i '/# ADMIN-CLI/d' "$SHELL_CFG"
        sed -i "\|admin-cli_archlinux/bin|d" "$SHELL_CFG"
        sed -i "\|\.admin-cli/bin|d" "$SHELL_CFG"
        sed -i "/alias admin=/d" "$SHELL_CFG"
        sed -i "/alias admin-update=/d" "$SHELL_CFG"
        sed -i '/^$/N;/^\n$/d' "$SHELL_CFG"
        echo -e "  ${YELLOW}Limpiada instalación anterior.${NC}"
    fi

    # Agregar bloque nuevo
    cat >> "$SHELL_CFG" << 'SHELLBLOCK'

# ADMIN-CLI
export PATH="$HOME/.admin-cli/bin:$PATH"
alias admin='$HOME/.admin-cli/admin.sh'
alias admin-update='cd $HOME/.admin-cli && git pull && echo "Admin-CLI actualizado."'
SHELLBLOCK

    echo -e "  ${GREEN}PATH, alias 'admin' y 'admin-update' configurados.${NC}"
fi

# ── Resultado ──
echo -e ""
if [ "$IS_UPDATE" = true ]; then
    echo -e "${GREEN}${BOLD}  Admin-CLI actualizado.${NC}"
else
    echo -e "${GREEN}${BOLD}  Instalación completa.${NC}"
    echo -e ""
    echo -e "  Ejecuta: ${BOLD}source $SHELL_CFG${NC}"
    echo -e "  Luego:   ${BOLD}admin${NC}"
fi
echo -e ""
echo -e "  Comandos disponibles:"
echo -e "    ${CYAN}admin${NC}          Menu principal"
echo -e "    ${CYAN}admin-update${NC}   Actualizar desde GitHub"
echo -e "    ${CYAN}cpu, net, hdw, procs, dock, deps...${NC}  Herramientas directas"
echo -e ""
