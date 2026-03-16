<p align="center">
  <img src="https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white" alt="Arch Linux"/>
  <img src="https://img.shields.io/badge/EndeavourOS-7B42BC?style=for-the-badge&logo=endeavouros&logoColor=white" alt="EndeavourOS"/>
  <img src="https://img.shields.io/badge/Shell-Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white" alt="Bash"/>
</p>

<h1 align="center">ADMIN-CLI</h1>
<p align="center"><b>Centro de comando para Arch Linux desde tu terminal.</b></p>
<p align="center">
Suite modular de herramientas CLI para administrar redes, hardware, Docker, proyectos, impresoras y mantenimiento del sistema.
</p>

---

## Vista previa

```
══════════════════════════════════════════════════════
         PANEL DE CONTROL: CPU & SISTEMA
══════════════════════════════════════════════════════
Modelo:      AMD Ryzen 7 PRO 7840U
Nucleos:     16 Hilos
Energia:     ⚡ CONECTADO  |  Gob: performance
Temp:        +52.4°C   |  RAM: 8.2Gi / 30Gi
IP Local:    192.168.1.50 (wlp1s0)
IP Publica:  xxx.xxx.xxx.xxx
--------------------------------------------------
╔══════════════════════════════════════════════════════╗
║                CENTRO DE COMANDO                     ║
╚══════════════════════════════════════════════════════╝
  [1] REDES & WIFI        (IPs, Puertos, Speedtest, Nmap)
  [2] PROCESOS            (Top CPU/RAM, Kill, Buscar)
  [3] HARDWARE            (Discos, USB, Sensores)
  [4] DOCKER MANAGER      (Contenedores, Logs, Shell)
  [5] PROYECTOS           (Repos Git, Pull Masivo, Config Rutas)
  [6] DEPENDENCIAS        (Limpiar node_modules, target/, venv)
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

El dashboard se **auto-refresca cada 3 segundos** con CPU, RAM, temperatura, IPs y procesos criticos en tiempo real, sin parpadeos.

---

## Instalacion

```bash
git clone https://github.com/Debaq/admin-cli-archlinux.git
cd admin-cli-archlinux
./install.sh
```

Esto agrega `bin/` al `$PATH` y crea el alias `admin`. Recarga tu shell y listo:

```bash
source ~/.bashrc   # o ~/.zshrc
admin
```

---

## Modulos

### Dashboard en tiempo real — `cpu`

Monitor del sistema integrado en el menu principal. Muestra modelo de CPU, frecuencias por nucleo, temperatura, RAM, IPs y alerta de procesos zombies o con consumo excesivo. Refresco suave con `tput` (sin parpadeos).

### Redes & WiFi — `net`

Panel completo de red: IP local/publica, ISP, gateway, firewall y tabla de puertos en escucha. Permite:

- Liberar un puerto matando su proceso
- Conectar WiFi (nmtui / nmcli / iwctl)
- Escaneo de red local con Nmap
- Speedtest integrado
- Limpieza masiva de procesos dev (Node, Python, Vite)

### Procesos — `procs`

Gestor interactivo con vistas por CPU, RAM, busqueda por nombre y listado completo. Mata procesos por PID con escalado a `kill -9` si resisten.

### Hardware — `hdw`

Inspector de discos/particiones, puertos serial (Arduino, ESP32), USB, GPU y webcams.

### Docker Manager — `dock`

Gestion completa de contenedores: listar, start/stop, logs en vivo, shell interactiva, imagenes, stats y prune. Instala Docker y configura permisos automaticamente si faltan.

### Gestor de Proyectos — `git-tool`

Escanea tus carpetas de proyectos y muestra el estado git de cada repo (limpio / modificado / untracked).

- **Rutas configurables** — guardadas en `~/.config/admin-cli/projects.conf`
- **Navegador de carpetas** — la primera vez, navegas visualmente desde `$HOME` para elegir donde estan tus proyectos
- Pull masivo de todos los repos
- Sub-shell directa en cualquier proyecto
- Agregar/eliminar directorios en cualquier momento con `[d]`

### Dependencias — `deps`

Gestor de dependencias integrado que **lee las mismas rutas** de `projects.conf`:

- Escanea `node_modules/`, `target/` (Rust), `dist/`, `.next/`, `.nuxt/`, `venv/`
- Tabla con espacio recuperable por proyecto y tipo
- **Verifica git antes de limpiar** — bloquea si hay cambios sin commitear
- Auto-commit con IA (Claude/Gemini) o stash antes de limpiar
- Inicializar git y crear repos en GitHub
- Migrar de npm a pnpm para ahorrar espacio
- Configurar `CARGO_TARGET_DIR` compartido para Rust/Tauri
- Activar proyectos (instalar deps) y lanzar dev servers

```bash
deps   # Tambien funciona como comando independiente
```

### Backup & Migracion — `bak`

Empaqueta configuraciones criticas en un `.tar.gz` portable:

| Que respalda | Detalle |
|---|---|
| **Brave** | Bookmarks, historial, login data |
| **FileZilla** | Sitios y configuracion |
| **Slicers 3D** | PrusaSlicer, OrcaSlicer, BambuStudio |
| **Impresoras** | Colas CUPS, PPDs custom, drivers HP |

Incluye restauracion completa.

### Software Center — `software`

Menu interactivo con `dialog` para instalar tu stack:

- **3D / CNC:** Blender, FreeCAD, PrusaSlicer, OrcaSlicer, Lychee, gSender
- **Electronica:** ST-Link, OpenOCD, Minicom
- **Dev:** VS Code, Docker, Node.js, Rust, Git, GitHub Desktop
- **Graficos:** GIMP, Inkscape, Kdenlive, OBS
- **Oficina:** LibreOffice, Teams, Zoom, Rambox, AnyDesk
- **Navegadores:** Brave, Firefox, Chromium
- **Utilidades:** VirtualBox, Balena Etcher, GParted, fuentes

Configura **Chaotic-AUR** automaticamente para binarios pre-compilados.

### Impresoras Epson — `printer`

- Instalar driver `escpr2` desde AUR
- Detectar y agregar impresoras por red/USB
- Agregar hojas de tamano custom al PPD (con/sin bordes)
- Compensacion de 3mm para borderless en Epson
- Listar y eliminar tamanos custom

### Mas modulos

| Modulo | Tecla | Que hace |
|---|---|---|
| **Update** | `u` | Actualiza con `yay` o `pacman -Syu` |
| **Clean** | `c` | Limpia cache, journals a 50MB, elimina huerfanos |
| **Logs** | `l` | Errores criticos del boot actual (`journalctl -p 3`) |
| **Reparar Arch** | `r` | Fix llaves PGP, instala yay, reflector, desbloquea db.lck |
| **Permisos** | `p` | Fix grupos serial/Arduino, chown, chmod +x |
| **Media A/V** | `m` | Forzar brillo, resetear pantallas KDE, reiniciar Pipewire |
| **Fixes** | `f` | Fix LibreOffice GTK3 en KDE |
| **Setup Base** | `0` | Chaotic-AUR + Micromamba + apps base |

---

## Estructura

```
admin-cli-archlinux/
├── admin.sh                    # Entry point — menu principal con dashboard
├── install.sh                  # Instalador (PATH + alias)
├── config/
│   └── colors.theme            # Paleta de colores centralizada
├── lib/
│   ├── utils.sh                # Helpers: pause, headers, sudo check
│   ├── system_ops.sh           # Update y clean del sistema
│   └── logs_ops.sh             # Logs criticos
└── bin/
    ├── cpu                     # Dashboard de sistema
    ├── net                     # Radar de red
    ├── procs                   # Gestor de procesos
    ├── hdw                     # Inspector de hardware
    ├── dock                    # Docker manager
    ├── git-tool                # Gestor de proyectos Git
    ├── deps                    # Gestor de dependencias
    ├── bak                     # Backup y migracion
    ├── software                # Centro de software
    ├── printer                 # Impresoras Epson
    ├── fix-arch                # Reparador de Pacman
    ├── setup                   # Setup base
    ├── perm                    # Permisos
    ├── media                   # Control A/V
    └── fixes                   # Fixes de apps
```

**Configuracion de usuario** (fuera del repo):
```
~/.config/admin-cli/
└── projects.conf               # Rutas de carpetas de proyectos
```

---

## Requisitos

**Minimos:** Arch Linux (o EndeavourOS/derivados), `bash`, `sudo`, `pacman`.

Las dependencias opcionales se ofrecen instalar automaticamente cuando se necesitan:

| Paquete | Usado por |
|---|---|
| `sysstat` | Dashboard (mpstat) |
| `lm_sensors` | Temperatura CPU |
| `nmap` | Escaneo de red |
| `speedtest-cli` | Test de velocidad |
| `jq` | Parseo IP publica |
| `dialog` | Software Center |
| `docker` | Docker Manager |
| `pamixer` | Control de volumen |
| `reflector` | Optimizar mirrors |

---

## Uso directo

Cada herramienta funciona de forma independiente sin necesidad del menu:

```bash
cpu          # Dashboard de sistema
net          # Radar de red
procs        # Gestor de procesos
hdw          # Inspector de hardware
dock         # Docker manager
git-tool     # Gestor de proyectos
perm         # Permisos
media        # Audio/Video
fix-arch     # Reparador de Arch
```

---

## Personalizacion

Edita `config/colors.theme` para cambiar la paleta de toda la suite:

```bash
GREEN="\033[32m"
BLUE="\033[34m"
CYAN="\033[36m"
RED="\033[31m"
YELLOW="\033[33m"
MAGENTA="\033[35m"
BOLD="\033[1m"
NC="\033[0m"
```

---

## Contribuir

1. Fork del repo
2. Crea tu branch (`git checkout -b feature/mi-modulo`)
3. Commit y push
4. Abre un Pull Request

---

<p align="center">
Hecho con Bash para Arch Linux
</p>
