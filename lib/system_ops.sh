#!/bin/bash

# Asume que utils.sh ya ha sido cargado o los colores están disponibles

system_update() {
    clear
    echo -e "${GREEN}${BOLD}=== ACTUALIZADOR DE SISTEMA (Arch/Endeavour) ===${NC}"
    echo -e "Ejecutando actualización completa y segura..."
    if command -v yay &> /dev/null; then
        yay -Syu
    else
        sudo pacman -Syu
    fi
    pause
}

system_clean() {
    clear
    echo -e "${YELLOW}${BOLD}=== LIMPIEZA DE MANTENIMIENTO ===${NC}"
    
    echo -e "\n${BOLD}1. Limpiando caché de paquetes...${NC}"
    if command -v paccache &> /dev/null; then
        sudo paccache -r
    else
        sudo pacman -Sc --noconfirm
    fi

    echo -e "\n${BOLD}2. Reduciendo logs del sistema a 50MB...${NC}"
    sudo journalctl --vacuum-size=50M

    echo -e "\n${BOLD}3. Buscando paquetes huérfanos...${NC}"
    ORPHANS=$(pacman -Qdtq)
    if [ -n "$ORPHANS" ]; then
        echo -e "   Eliminando: $ORPHANS"
        sudo pacman -Rns $ORPHANS --noconfirm
    else
        echo "   ¡No hay huérfanos! Sistema limpio."
    fi
    pause
}
