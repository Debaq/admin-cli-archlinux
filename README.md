# 🐧 ADMIN-CLI: Arch Linux Command Center

> **Tu navaja suiza para la administración de sistemas en Arch Linux / EndeavourOS.**

Una suite de herramientas CLI modular, rápida y visualmente cuidada para gestionar hardware, redes, proyectos y mantenimiento del sistema sin salir de la terminal.

---

## 🚀 Características Principales

### 🖥️ Dashboard "Anti-Flicker"
Monitor de sistema en tiempo real (CPU, RAM, Temperatura, IPs) integrado en el menú principal. Utiliza `sysstat` y buffers de pantalla para una actualización suave sin parpadeos.

### 🛠️ Módulos Incluidos

| Módulo | Comando | Descripción |
| :--- | :--- | :--- |
| **REDES** | `bin/net` | **Radar de Red:** Ver IP pública/ISP, Speedtest integrado, Escáner de LAN (Nmap), gestión de puertos y conexión WiFi (NMTUI/IWCTL). |
| **PROCESOS** | `bin/procs` | **Top Interactivo:** Ver procesos por consumo CPU/RAM, buscar por nombre y matar procesos rebeldes. |
| **HARDWARE** | `bin/hdw` | **Inspector:** Lista discos, particiones, dispositivos USB y puertos Serial/TTY (Arduino/ESP). |
| **DOCKER** | `bin/dock` | **Manager:** Ver contenedores, logs en vivo, entrar a la shell del contenedor y limpieza del sistema. |
| **GIT** | `bin/git-tool` | **Torre de Control:** Escanea tus carpetas de proyectos, muestra estado (Dirty/Clean) y permite `git pull` masivo. |
| **BACKUP** | `bin/bak` | **Migración:** Empaqueta configuraciones críticas (Slicers 3D, FileZilla, Drivers Impresora, Brave) en un `.tar.gz` portable. |
| **SOFTWARE** | `bin/software`| **Instalador:** Menú interactivo (`dialog`) para instalar tu stack completo (3D, Dev, Office) con Chaotic-AUR automático. |

---

## 📦 Instalación

1.  Clona o descarga este repositorio.
2.  Ejecuta el script de instalación:

```bash
./install.sh
```

Esto añadirá la carpeta `bin/` a tu `$PATH` y creará el alias `admin`.

3.  Reinicia tu terminal o ejecuta `source ~/.bashrc` (o `~/.zshrc`).
4.  Escribe `admin` para empezar.

---

## 🎮 Uso

Simplemente escribe `admin` en tu terminal.

```text
╔══════════════════════════════════════════════════════╗
║                CENTRO DE COMANDO                     ║
╚══════════════════════════════════════════════════════╝
  [1] REDES & WIFI        (IPs, Puertos, Speedtest, Nmap)
  [2] PROCESOS            (Top CPU/RAM, Kill, Buscar)
  [3] HARDWARE            (Discos, USB, Sensores)
  [4] DOCKER MANAGER      (Contenedores, Logs, Shell)
  [5] GIT PROJECTS        (Estado Repos, Pull Masivo)
  ...
```

### Atajos Rápidos
También puedes invocar las herramientas individualmente desde cualquier lugar:
*   `cpu` -> Dashboard de recursos.
*   `net` -> Radar de red.
*   `hdw` -> Info de hardware.
*   `dock` -> Gestión de contenedores.

---

## ⚙️ Personalización

*   **Temas:** Edita `config/colors.theme` para cambiar la paleta de colores de toda la suite.
*   **Librerías:** Las funciones comunes están en `lib/utils.sh`.

---

## 📋 Requisitos

El sistema intentará instalar automáticamente las dependencias si faltan, pero idealmente requiere:
*   **Base:** `bash`, `sudo`, `pacman`.
*   **Visual:** `dialog` (para menús), `ncurses`.
*   **Red:** `nmap`, `speedtest-cli`, `jq`, `bind` (dig).
*   **Sistema:** `sysstat` (mpstat), `lm_sensors`.

---

## 🛡️ Backup & Migración

El módulo `bin/bak` está diseñado específicamente para creadores y desarrolladores. Respalda:
*   **Impresión 3D:** Perfiles de Orca Slicer, Prusa Slicer, Bambu Studio.
*   **Desarrollo:** Configuración de FileZilla.
*   **Hardware:** Drivers de impresión modificados (PPDs) y colas de CUPS.

---

Hecho con ❤️ y Bash para Arch Linux.
