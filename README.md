<p align="center">
  <img src="https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white" alt="Arch Linux"/>
  <img src="https://img.shields.io/badge/EndeavourOS-7B42BC?style=for-the-badge&logo=endeavouros&logoColor=white" alt="EndeavourOS"/>
  <img src="https://img.shields.io/badge/Shell-Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white" alt="Bash"/>
  <img src="https://img.shields.io/badge/License-MIT-blue?style=for-the-badge" alt="License"/>
</p>

<h1 align="center">ADMIN-CLI</h1>
<p align="center"><b>Centro de comando para Arch Linux desde tu terminal.</b></p>
<p align="center">
Suite modular de herramientas CLI para administrar hardware, redes, Docker, proyectos Git, impresoras y mantenimiento del sistema — todo sin salir de la terminal.
</p>

---

## Vista previa

```
╔══════════════════════════════════════════════════════╗
║                CENTRO DE COMANDO                     ║
╚══════════════════════════════════════════════════════╝
  [1] REDES & WIFI        (IPs, Puertos, Speedtest, Nmap)
  [2] PROCESOS            (Top CPU/RAM, Kill, Buscar)
  [3] HARDWARE            (Discos, USB, Sensores)
  [4] DOCKER MANAGER      (Contenedores, Logs, Shell)
  [5] GIT PROJECTS        (Estado Repos, Pull Masivo)
  ──────────────────────────────────────────────────────
  [u] UPDATE SYSTEM       (Actualizar: Pacman/Yay)
  [c] CLEAN SYSTEM        (Limpiar Cache/Huerfanos)
  [l] LOGS & ERRORES      (Ver fallos de hoy)
  [r] REPARAR ARCH        (Fix PGP Keys, Mirrors)
  ──────────────────────────────────────────────────────
  [p] PERMISOS            [m] MEDIA (A/V)
  [b] BACKUP/MIGRAR       [i] IMPRESORAS
  [f] FIXES APPS          [0] SETUP BASE
  [S] SOFTWARE CENTER     [q] SALIR
```

El dashboard se **auto-refresca cada 3 segundos** mostrando CPU, RAM, temperatura, IPs y procesos criticos en tiempo real, sin parpadeos.

---

## Instalacion

```bash
git clone https://github.com/Debaq/admin-cli-archlinux.git
cd admin-cli-archlinux
./install.sh
```

Esto hace tres cosas:
1. Agrega `bin/` a tu `$PATH` (para usar las herramientas directamente)
2. Crea el alias `admin` para lanzar el menu principal
3. Da permisos de ejecucion a todos los scripts

Despues recarga tu shell:

```bash
source ~/.bashrc   # o ~/.zshrc
```

Escribe `admin` para empezar.

---

## Modulos

### Dashboard en tiempo real (`cpu`)

Monitor integrado en el menu principal. Muestra modelo de CPU, frecuencias por nucleo, temperatura, RAM, IPs y detecta procesos zombies o con consumo alto. Usa `tput` para refrescar sin parpadeos.

```bash
cpu   # Tambien funciona como comando independiente
```

### Redes & WiFi (`net`)

Informacion completa de red: IP local/publica, ISP, gateway, estado del firewall y tabla de puertos en escucha. Acciones interactivas:

- Liberar un puerto matando el proceso
- Conectar/configurar WiFi (nmtui, nmcli o iwctl)
- Escaneo de red local con Nmap
- Speedtest integrado
- Limpieza masiva de procesos dev (Node, Python, Vite)

### Procesos (`procs`)

Gestor interactivo con vistas por consumo de CPU, RAM, busqueda por nombre y listado completo. Permite matar procesos directamente por PID, con escalado automatico a `sudo kill -9` si es necesario.

### Hardware (`hdw`)

Inspector que muestra discos/particiones (sin loops), puertos serial/TTY (Arduino, ESP32), dispositivos USB, GPU y camaras/webcams detectadas.

### Docker Manager (`dock`)

Gestion completa de contenedores:
- Listar, iniciar, detener y eliminar contenedores
- Ver logs en vivo (`docker logs -f`)
- Entrar a la shell del contenedor (`bash` o `sh`)
- Ver imagenes locales y stats en tiempo real
- `docker system prune` con confirmacion

Instala Docker automaticamente si no lo encuentra y configura los permisos de grupo.

### Git Projects (`git-tool`)

Escanea automaticamente tus carpetas de proyectos (`~/Proyectos`, `~/Projects`, `~/dev`, etc.) y muestra el estado de cada repo: limpio, modificado o con archivos sin trackear.

- Pull masivo de todos los repos
- Abrir sub-shell directamente en un proyecto
- Re-escaneo bajo demanda

### Backup & Migracion (`bak`)

Empaqueta configuraciones criticas en un `.tar.gz` portable:

| Categoria | Que respalda |
|---|---|
| **Navegador** | Bookmarks, historial y datos de Brave |
| **FTP** | Sitios y config de FileZilla |
| **Impresion 3D** | Perfiles de PrusaSlicer, OrcaSlicer, BambuStudio |
| **Impresoras** | Colas CUPS, PPDs custom, drivers HP |

Incluye restauracion con un comando.

### Software Center (`software`)

Menu interactivo con `dialog` para instalar tu stack completo. Categorias:

- **3D & CNC:** Blender, FreeCAD, PrusaSlicer, OrcaSlicer, Lychee, gSender
- **Electronica:** ST-Link, OpenOCD, Minicom
- **Desarrollo:** VS Code, Docker, Node.js, Rust, Python, Git
- **Graficos:** GIMP, Inkscape, Kdenlive, OBS
- **Oficina:** LibreOffice, Teams, Zoom, Rambox, AnyDesk
- **Navegadores:** Brave, Firefox, Chromium
- **Utilidades:** VirtualBox, Balena Etcher, GParted, fuentes

Configura **Chaotic-AUR** automaticamente para acelerar las instalaciones desde AUR.

### Impresoras Epson (`printer`)

Modulo especializado para impresoras Epson:
- Instalar driver `escpr2` desde AUR
- Detectar y agregar impresoras por red o USB
- **Agregar hojas de tamano custom** al PPD (con/sin bordes)
- Compensacion automatica de 3mm para borderless
- Listar y eliminar tamanos custom

### Otros modulos

| Modulo | Comando | Funcion |
|---|---|---|
| **Update** | `u` | Actualiza con `yay` o `pacman -Syu` |
| **Clean** | `c` | Limpia cache, reduce journals a 50MB, elimina huerfanos |
| **Logs** | `l` | Muestra errores criticos del boot actual (`journalctl -p 3`) |
| **Reparar Arch** | `fix-arch` | Repara llaves PGP, instala yay, optimiza mirrors con reflector, desbloquea db.lck |
| **Permisos** | `perm` | Repara grupos serial/Arduino, chown recursivo, chmod +x |
| **Media A/V** | `media` | Forzar brillo, resetear pantallas KDE, reiniciar Pipewire, unmute de emergencia |
| **Fixes** | `fixes` | Fix LibreOffice GTK3 en KDE (alias + parcheado de .desktop) |
| **Setup Base** | `setup` | Configuracion inicial: Chaotic-AUR + Micromamba + apps base |

---

## Estructura del proyecto

```
admin-cli-archlinux/
├── admin.sh              # Entry point - Menu principal con dashboard
├── install.sh            # Instalador (PATH + alias)
├── config/
│   └── colors.theme      # Paleta de colores centralizada
├── lib/
│   ├── utils.sh          # Helpers: pause, headers, sudo check
│   ├── system_ops.sh     # Logica de update y clean
│   └── logs_ops.sh       # Visualizacion de logs criticos
└── bin/
    ├── cpu               # Dashboard de sistema
    ├── net               # Radar de red
    ├── procs             # Gestor de procesos
    ├── hdw               # Inspector de hardware
    ├── dock              # Docker manager
    ├── git-tool          # Estado de repos Git
    ├── bak               # Backup y migracion
    ├── software          # Centro de software (dialog)
    ├── printer           # Gestion impresoras Epson
    ├── fix-arch          # Reparador de Pacman
    ├── setup             # Setup base del sistema
    ├── perm              # Gestor de permisos
    ├── media             # Control A/V
    └── fixes             # Fixes de apps
```

---

## Requisitos

**Minimos** (el resto se instala bajo demanda):

- Arch Linux, EndeavourOS o derivados
- `bash`, `sudo`, `pacman`

**Recomendados** (se ofrecen instalar automaticamente si faltan):

| Paquete | Usado por |
|---|---|
| `sysstat` | Dashboard CPU (mpstat) |
| `lm_sensors` | Temperatura del procesador |
| `nmap` | Escaneo de red local |
| `speedtest-cli` | Test de velocidad |
| `jq` | Parseo de IP publica |
| `dialog` | Software Center |
| `docker` | Docker Manager |
| `pamixer` | Control de volumen |

---

## Uso directo de herramientas

Ademas del menu principal, cada herramienta funciona de forma independiente:

```bash
cpu          # Dashboard de sistema
net          # Radar de red
procs        # Gestor de procesos
hdw          # Inspector de hardware
dock         # Docker manager
git-tool     # Estado de repos
perm         # Permisos
media        # Audio/Video
```

---

## Personalizacion

Edita `config/colors.theme` para cambiar la paleta de colores de toda la suite:

```bash
GREEN="\033[32m"
BLUE="\033[34m"
CYAN="\033[36m"
# ...
```

---

## Contribuir

1. Fork del repo
2. Crea tu branch (`git checkout -b feature/mi-modulo`)
3. Commit tus cambios
4. Push al branch
5. Abre un Pull Request

---

<p align="center">Hecho con bash para Arch Linux.</p>
