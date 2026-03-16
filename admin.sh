#!/bin/bash

# ==========================================
# 0. INICIALIZACIÓN
# ==========================================

# Determinar directorio root
export ADMIN_CLI_ROOT=$(dirname "$(readlink -f "$0")")

# Importar librerías
source "$ADMIN_CLI_ROOT/lib/utils.sh"
source "$ADMIN_CLI_ROOT/lib/system_ops.sh"
source "$ADMIN_CLI_ROOT/lib/logs_ops.sh"

# CHECK DE COMPLEMENTOS (Sysstat)
if ! command -v mpstat &> /dev/null; then
    clear
    echo -e "${YELLOW}${BOLD}⚠️  Falta un complemento recomendado: sysstat${NC}"
    echo -e "Es necesario para el monitoreo en tiempo real del Dashboard."
    echo -e ""
    echo -ne "¿Instalarlo ahora (Recomendado para Arch)? [S/n] "
    read -r INST_OPT
    if [[ -z "$INST_OPT" || "$INST_OPT" =~ ^[sS]$ ]]; then
        sudo pacman -S --noconfirm sysstat
        echo -e "${GREEN}Instalado. Continuando...${NC}"
        sleep 1
    fi
fi

# ==========================================
# 1. BUCLE PRINCIPAL (MENÚ)
# ==========================================

# Bandera para forzar limpieza total al volver de una herramienta
FORCE_CLEAR=1

while true; do
    # Si venimos de una herramienta, borrar pantalla completa.
    # Si es solo refresco automático, usar tput para suavidad.
    if [ "$FORCE_CLEAR" -eq 1 ]; then
        clear
        FORCE_CLEAR=0
    else
        tput cup 0 0
    fi

    # Dashboard CPU (Modo no interactivo)
    if [ -f "$ADMIN_CLI_ROOT/bin/cpu" ]; then
        bash "$ADMIN_CLI_ROOT/bin/cpu" dashboard
    else
        echo -e "${RED}Error: No encuentro el script bin/cpu${NC}"
    fi

    echo -e ""
    echo -e "${BLUE}${BOLD}╔══════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}${BOLD}║                CENTRO DE COMANDO                     ║${NC}"
    echo -e "${BLUE}${BOLD}╚══════════════════════════════════════════════════════╝${NC}"
    
    # --- BLOQUE 1: HERRAMIENTAS DIARIAS (Números) ---
    echo -e "  ${CYAN}[1]${NC} ${BOLD}REDES & WIFI${NC}        (IPs, Puertos, Speedtest, Nmap)"
    echo -e "  ${CYAN}[2]${NC} ${BOLD}PROCESOS${NC}            (Top CPU/RAM, Kill, Buscar)"
    echo -e "  ${CYAN}[3]${NC} ${BOLD}HARDWARE${NC}            (Discos, USB, Sensores)"
    echo -e "  ${CYAN}[4]${NC} ${BOLD}DOCKER MANAGER${NC}      (Contenedores, Logs, Shell)"
    echo -e "  ${CYAN}[5]${NC} ${BOLD}PROYECTOS${NC}           (Repos Git, Pull Masivo, Config Rutas)"
    echo -e "  ${CYAN}[6]${NC} ${BOLD}DEPENDENCIAS${NC}        (Limpiar node_modules, target/, venv)"

    echo -e "${BLUE}  ──────────────────────────────────────────────────────${NC}"
    
    # --- BLOQUE 2: MANTENIMIENTO DEL SISTEMA (Letras Mnemotécnicas) ---
    echo -e "  ${YELLOW}[u]${NC} ${BOLD}UPDATE SYSTEM${NC}       (Actualizar: Pacman/Yay)"
    echo -e "  ${YELLOW}[c]${NC} ${BOLD}CLEAN SYSTEM${NC}        (Limpiar Caché/Huérfanos)"
    echo -e "  ${YELLOW}[l]${NC} ${BOLD}LOGS & ERRORES${NC}      (Ver fallos de hoy)"
    echo -e "  ${YELLOW}[r]${NC} ${BOLD}REPARAR ARCH${NC}        (Fix PGP Keys, Mirrors)"

    echo -e "${BLUE}  ──────────────────────────────────────────────────────${NC}"
    
    # --- BLOQUE 3: UTILIDADES & CONFIG ---
    echo -e "  ${MAGENTA}[p]${NC} PERMISOS             (Fix Grupos, Chown, Chmod)"
    echo -e "  ${MAGENTA}[m]${NC} MEDIA (A/V)          (Audio, Brillo, Pantallas)"
    echo -e "  ${MAGENTA}[b]${NC} BACKUP/MIGRAR        (FileZilla, Brave, Impresoras)"
    echo -e "  ${MAGENTA}[i]${NC} IMPRESORAS           (Epson, HP LaserJet)"
    echo -e "  ${MAGENTA}[f]${NC} FIXES APPS           (LibreOffice GTK3, etc.)"
    echo -e "  ${MAGENTA}[0]${NC} SETUP BASE           (Instalación Automática Básica)"
    echo -e "  ${MAGENTA}[S]${NC} SOFTWARE CENTER      (Menú Selección Interactivo)"
    echo -e "  ${GREEN}[x]${NC} ACTUALIZAR ADMIN-CLI (git pull)"
    echo -e "  ${RED}[q]${NC} SALIR"
    
    echo -e ""
    echo -e "${CYAN}(Auto-refresh)${NC}"
    echo -ne "${BOLD}Selecciona una herramienta > ${NC}"
    
    # Esperamos 3 segundos. Si timeout, repite loop (redibuja dashboard)
    read -t 3 -n 1 -r OPTION

    # Si OPTION está vacío (timeout), continuamos el loop para refrescar
    if [ -z "$OPTION" ]; then
        continue
    fi

    # Si el usuario pulsó algo, forzamos limpieza completa para la próxima vez
    FORCE_CLEAR=1

    # Resetear cursor abajo y limpiar pantalla para la herramienta seleccionada
    echo ""
    clear 

    case $OPTION in
        1) bash "$ADMIN_CLI_ROOT/bin/net" || pause ;;
        2) bash "$ADMIN_CLI_ROOT/bin/procs" || pause ;;
        3) bash "$ADMIN_CLI_ROOT/bin/hdw" ; pause ;;
        4) bash "$ADMIN_CLI_ROOT/bin/dock" ;;
        5) bash "$ADMIN_CLI_ROOT/bin/git-tool" ;;
        6) bash "$ADMIN_CLI_ROOT/bin/deps" ;;
        
        u|U) system_update ;;
        c|C) system_clean ;;
        l|L) logs_critical ;;
        r|R) bash "$ADMIN_CLI_ROOT/bin/fix-arch" || pause ;;
        
        p|P) bash "$ADMIN_CLI_ROOT/bin/perm" || pause ;;
        m|M) bash "$ADMIN_CLI_ROOT/bin/media" || pause ;;
        b|B) bash "$ADMIN_CLI_ROOT/bin/bak" || pause ;;
        i|I) bash "$ADMIN_CLI_ROOT/bin/printer" || pause ;;
        f|F) bash "$ADMIN_CLI_ROOT/bin/fixes" || pause ;;
        0)   bash "$ADMIN_CLI_ROOT/bin/setup" || pause ;;
        s|S) bash "$ADMIN_CLI_ROOT/bin/software" || pause ;;
        
        x|X)
            echo -e "${CYAN}${BOLD}Actualizando Admin-CLI...${NC}"
            cd "$ADMIN_CLI_ROOT"
            git pull
            echo -e "${GREEN}Listo. Reinicia admin para aplicar cambios.${NC}"
            pause
            ;;
        q|Q)
            clear
            echo -e "${GREEN}¡Sistema optimizado y listo! Hasta luego.${NC}"
            exit 0
            ;;
        *) 
            echo -e "${RED}Opción no válida.${NC}" 
            sleep 0.5
            ;;
    esac
done
