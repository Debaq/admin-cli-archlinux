# 🚀 ADMIN-CLI: Plan de Refactorización Modular

**Fecha:** 27 de Enero, 2026
**Objetivo:** Transformar la colección de scripts en una suite de administración de sistemas modular, escalable y mantenible para Arch Linux/EndeavourOS.

---

## 1. 🏗️ Nueva Arquitectura del Proyecto

En lugar de tener scripts sueltos en `~/`, crearemos un directorio dedicado (e.g., `~/.admin-cli`) que actúe como repositorio.

```text
~/.admin-cli/
├── admin.sh             # (Entry Point) El orquestador principal (Menú)
├── install.sh           # Script de instalación (Symlinks a /usr/local/bin o Alias)
├── config/              # Configuraciones de usuario
│   ├── settings.conf    # Preferencias globales
│   └── colors.theme     # Definiciones de colores (para cambiar temas)
├── lib/                 # Librerías compartidas (Funciones internas)
│   ├── utils.sh         # Helpers (pausa, headers, sudo check)
│   ├── system_ops.sh    # Lógica de Actualización y Limpieza (antes en admin)
│   └── logs_ops.sh      # Lógica de visualización de logs
└── bin/                 # Herramientas independientes (Los scripts actuales)
    ├── cpu              # Monitor de Hardware y Procesos
    ├── net              # Gestor de Red y Puertos
    ├── procs            # Gestor de Procesos Avanzado
    ├── hdw              # Inspector de Hardware
    ├── perm             # Gestor de Permisos
    ├── media            # Control A/V (Brillo/Audio)
    └── fix-arch         # Reparador de Sistema
```

---

## 2. 📦 Inventario y Migración

| Script Actual | Nueva Ubicación | Cambios Necesarios |
| :--- | :--- | :--- |
| `~/admin` | `~/.admin-cli/admin.sh` | **Refactorizar:** Extraer funciones internas (`tool_update`, `tool_clean`) a archivos en `lib/`. Convertirlo en un lanzador que importa `lib/utils.sh`. |
| `~/cpu` | `~/.admin-cli/bin/cpu` | Eliminar función `setup_alias` (lo manejará `install.sh`). Estandarizar colores importando `config/colors.theme`. |
| `~/net` | `~/.admin-cli/bin/net` | Igual que cpu. Añadir soporte para logs. |
| `~/procs` | `~/.admin-cli/bin/procs` | Igual que cpu. |
| `~/hdw` | `~/.admin-cli/bin/hdw` | Igual que cpu. |
| `~/perm` | `~/.admin-cli/bin/perm` | Igual que cpu. |
| `~/media` | `~/.admin-cli/bin/media` | Igual que cpu. |
| `~/fix-arch` | `~/.admin-cli/bin/fix-arch`| Igual que cpu. |

---

## 3. 💡 Roadmap: Nuevas Ideas y Módulos

Herramientas sugeridas para desarrollar en la Fase 2:

### A. 🐳 `dock` (Docker Manager)
*   **Problema:** Gestionar contenedores docker es tedioso por CLI.
*   **Función:** Listar contenedores, ver logs en vivo, entrar a la terminal de un contenedor (`docker exec -it`), matar contenedores zombies, limpiar imágenes no usadas (`prune`).

### B. 🐙 `git-tool` (Project Manager)
*   **Problema:** Tienes muchos proyectos y olvidas hacer pull/push o ver el estado.
*   **Función:** "Dashboard de Proyectos". Escanea tu carpeta `~/Proyectos`, te dice cuáles tienen cambios sin commitear y permite hacer `git pull` masivo.

### C. 🔑 `ssh-man` (SSH Manager)
*   **Problema:** Recordar IPs y usuarios de servidores remotos.
*   **Función:** Menú interactivo que lee tu `~/.ssh/config` y te permite conectarte a servidores con un enter.

### D. 💾 `bak` (Backup System)
*   **Problema:** Perder configuraciones.
*   **Función:** Script sencillo usando `rsync` para respaldar carpetas clave (`~/.config`, `~/Documentos`) a un disco externo o ruta específica.

---

## 4. 🛠️ Flujo de Trabajo para la Siguiente Sesión

1.  **Inicialización:** Crear la estructura de carpetas `~/.admin-cli`.
2.  **Migración:** Mover los scripts actuales a `bin/` y limpiarlos (quitar la autoconfiguración de alias individual).
3.  **Librerías:** Crear `lib/utils.sh` con los colores y funciones comunes para no repetir código.
4.  **Installer:** Crear un `install.sh` que añada `~/.admin-cli/bin` al PATH del usuario (mucho más limpio que llenar el `.bashrc` de alias).
5.  **Expansión:** Comenzar a programar el módulo `dock` o `git-tool`.
