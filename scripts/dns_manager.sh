#!/bin/bash

# --- INFO DE RED Y ESTADO ---
mostrar_info() {
    clear
    echo "==========================================="
    echo "       ESTADO DEL SISTEMA DNS"
    echo "==========================================="
    echo -n "IP Local: "
    hostname -I | awk '{print $1}'
    echo -n "Estado Bind9 (Nativo): "
    systemctl is-active --quiet named && echo "ACTIVO" || echo "INACTIVO"
    echo -n "Estado Docker (Contenedor): "
    docker ps | grep -q dns-server && echo "ACTIVO" || echo "INACTIVO"
    echo "==========================================="
}

# --- ACCIONES ---
instalar_nativo() {
    echo "Instalando BIND en Arch Linux..."
    sudo pacman -S --noconfirm bind dnsutils
    sudo cp ../config/named.conf.options /etc/named.conf.options
    sudo systemctl enable --now named
}

instalar_docker() {
    echo "Construyendo imagen y levantando contenedor..."
    cd ../docker
    docker build -t dns-ubuntu-image .
    docker run -d --name dns-server -p 53:53/udp -p 53:53/tcp dns-ubuntu-image
    cd ../scripts
}

# --- MENÚ INTERACTIVO ---
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
