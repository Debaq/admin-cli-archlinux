#!/bin/bash

logs_critical() {
    clear
    echo -e "${RED}${BOLD}=== ERRORES CRÍTICOS (BOOT ACTUAL) ===${NC}"
    sudo journalctl -p 3 -xb
    pause
}
