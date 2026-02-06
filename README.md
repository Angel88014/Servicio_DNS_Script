# 🌐 Enterprise DNS Automation Suite (Arch Linux & Docker)

[![Project Status: Active](https://img.shields.io/badge/Project%20Status-Active-brightgreen.svg)]()
[![OS: Arch Linux](https://img.shields.io/badge/OS-Arch%20Linux-blue.svg)]()
[![Service: BIND9](https://img.shields.io/badge/Service-BIND9-orange.svg)]()

Este proyecto consiste en un sistema de gestión automatizada para un servidor DNS basado en **BIND9**. La solución está diseñada para ejecutarse de forma aislada mediante **Docker**, permitiendo una administración sencilla y robusta a través de un script de control en Bash.

---

## 🏗️ Arquitectura y Stack Tecnológico

El sistema se divide en tres capas desacopladas para garantizar la portabilidad y limpieza del sistema host:

| Capa | Tecnología | Función |
| :--- | :--- | :--- |
| **Orquestación** | Bash Script | Control Plane: Maneja el ciclo de vida del contenedor y la lógica CLI. |
| **Servicio** | Docker (Ubuntu 22.04) | Ejecuta BIND9 de forma aislada para seguridad y portabilidad. |
| **Configuración** | BIND9 Config | Define políticas de recursión y forwarders (8.8.8.8). |

---

## 🚀 Características principales
- **Despliegue con Docker**: Servidor DNS basado en Ubuntu 22.04 totalmente aislado.
- **Script de Gestión (CLI)**: Herramienta avanzada para instalar, iniciar, detener y monitorizar.
- **Optimizado para Arch Linux**: Solución de errores comunes de red y compatibilidad (`ip route` vs `hostname`).
- **Doble Interfaz**: Soporta tanto menú interactivo como ejecución directa por parámetros.

---

## 📂 Estructura del Proyecto
El proyecto se ha organizado siguiendo una metodología de diseño por módulos:
- `/docker`: Contiene el `Dockerfile` y la definición de la imagen.
- `/scripts`: El núcleo lógico del proyecto (`dns_manager.sh`).
- `/config`: Archivos de configuración de BIND9 (`named.conf.options`).

---

## 🛠️ Instalación y Uso rápido

### Requisitos previos
- Docker instalado y con permisos para el usuario actual.
- Herramientas de diagnóstico DNS (`bind-tools` en Arch o `dnsutils` en Debian).

### Paso 1: Clonar el repositorio
```bash
git clone [https://github.com/Angel88014/Servicio_DNS_Script.git](https://github.com/Angel88014/Servicio_DNS_Script.git)
cd Servicio_DNS_Script
chmod +x scripts/dns_manager.sh
