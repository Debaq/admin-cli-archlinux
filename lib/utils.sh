#!/bin/bash

# Determinar directorio base si no está definido
if [ -z "$ADMIN_CLI_ROOT" ]; then
    # Asume que este script está en lib/ y el root está un nivel arriba
    ADMIN_CLI_ROOT=$(dirname "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")")
fi

# Cargar colores
source "$ADMIN_CLI_ROOT/config/colors.theme"

# Función para pausar
pause(){
    echo -e "\n${BLUE}Presiona ${BOLD}[Enter]${NC}${BLUE} para volver al menú...${NC}"
    read -r
}

# Refrescar credenciales de sudo
check_sudo() {
    sudo -v
}

# Header estándar
print_header() {
    local title="$1"
    clear
    echo -e "${BLUE}${BOLD}==================================================${NC}"
    echo -e "           ${YELLOW}${BOLD}$title${NC}"
    echo -e "${BLUE}${BOLD}==================================================${NC}"
}

