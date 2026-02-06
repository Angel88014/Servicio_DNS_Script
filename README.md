# 🌐 Servidor DNS Automatizado (BIND9 + Docker)

Este proyecto consiste en un sistema de gestión automatizada para un servidor DNS basado en **BIND9**. La solución está diseñada para ejecutarse de forma aislada mediante **Docker**, permitiendo una administración sencilla a través de un script de control en Bash.

## 🚀 Características principales
- **Despliegue con Docker**: Servidor DNS basado en Ubuntu 22.04 totalmente aislado del sistema host.
- **Script de Gestión (CLI)**: Herramienta en Bash para instalar, iniciar, detener y monitorizar el servicio.
- **Soporte Multi-distribución**: Optimizado y testeado en **Arch Linux**, con detección automática de red.
- **Doble Interfaz**: Soporta tanto menú interactivo como parámetros por línea de comandos.

## 📂 Estructura del Proyecto
El proyecto se ha organizado en módulos para facilitar su escalabilidad:
- `/docker`: Contiene el `Dockerfile` y la receta de la imagen.
- `/scripts`: El corazón del proyecto, el script `dns_manager.sh`.
- `/config`: Archivos de configuración de BIND9 (`named.conf.options`).

## 🛠️ Instalación y Uso rápido

### Requisitos previos
- Docker instalado y con permisos para tu usuario.
- Herramientas de red (`bind-tools` o `dnsutils`).

### Paso 1: Clonar el repositorio
```bash
git clone [https://github.com/Angel88014/Servicio_DNS_Script.git](https://github.com/Angel88014/Servicio_DNS_Script.git)
cd Servicio_DNS_Script

🔍 Verificación del Sistema
Una vez que el estado aparezca como ACTIVO en el script, puedes verificar la resolución DNS real ejecutando una consulta contra tu propio contenedor:

```bash
dig @127.0.0.1 google.com
Si recibes una respuesta en la "Answer Section", el servidor está operando correctamente.
