#!/bin/bash

mostrar_info() {
    clear
    echo "==========================================="
    echo "       ESTADO DEL SISTEMA DNS"
    echo "==========================================="
    echo -n "IP Local: "
    ip addr show $(ip route | awk '/default/ { print $5 }') | grep "inet " | awk '{print $2}' | cut -d'/' -f1
    echo -n "Estado Bind9 (Nativo): "
    systemctl is-active --quiet named && echo "ACTIVO" || echo "INACTIVO"
    echo -n "Estado Docker (Contenedor): "
    docker ps | grep -q dns-server && echo "ACTIVO" || echo "INACTIVO"
    echo "==========================================="
}

instalar_nativo() {
    echo "Instalando BIND en Arch Linux..."
    sudo pacman -S --noconfirm bind dnsutils
    sudo cp ../config/named.conf.options /etc/named.conf.options
    sudo systemctl enable --now named
}

instalar_docker() {
    echo "Limpiando y levantando contenedor..."
    BASE_DIR=$(cd "$(dirname "$0")/.." && pwd)
    
    docker rm -f dns-server >/dev/null 2>&1
    
    cd "$BASE_DIR/docker" || exit
    docker build -t dns-ubuntu-image .
    docker run -d --name dns-server -p 53:53/udp -p 53:53/tcp dns-ubuntu-image
    cd "$BASE_DIR/scripts" || exit
    echo "¡Servidor DNS en Docker listo!"
    sleep 2
}

if [ ! -z "$1" ]; then
    case $1 in
        --install-docker)
            instalar_docker
            exit 0
            ;;
        --start)
            docker start dns-server
            echo "Servidor DNS iniciado."
            exit 0
            ;;
        --stop)
            docker stop dns-server
            echo "Servidor DNS detenido."
            exit 0
            ;;
        --help)
            echo "Uso: $0 {--install-docker|--start|--stop|--help}"
            exit 0
            ;;
        *)
            echo "Opción no válida: $1"
            echo "Usa --help para ver las opciones."
            exit 1
            ;;
    esac
fi

mostrar_info
echo "1) Instalar servicio (Nativo - pacman)"
echo "2) Instalar servicio (Docker)"
echo "3) Eliminar servicio"
echo "4) Puesta en marcha (Start)"
echo "5) Parada (Stop)"
echo "6) Ver Logs"
echo "7) Salir"
read -p "Selecciona una opción: " opcion

case $opcion in
    1) instalar_nativo ;;
    2) instalar_docker ;;
    3) sudo pacman -Rs bind ;;
    4) sudo systemctl start named ;;
    5) sudo systemctl stop named ;;
    6) journalctl -u named -n 20 ;;
    7) exit 0 ;;
esac

