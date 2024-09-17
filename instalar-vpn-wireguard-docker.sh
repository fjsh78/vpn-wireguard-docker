#!/bin/bash

# Salir en caso de error
set -e

# Comprobar que el script se ejecute como root
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, ejecuta el script como root."
  exit 1
fi

# Configurar sources.list de Debian
echo "Configurando sources.list de Debian..."
cat <<EOF > /etc/apt/sources.list
deb http://deb.debian.org/debian bookworm main non-free-firmware
deb-src http://deb.debian.org/debian bookworm main non-free-firmware

deb http://deb.debian.org/debian-security/ bookworm-security main non-free-firmware
deb-src http://deb.debian.org/debian-security/ bookworm-security main non-free-firmware

deb http://deb.debian.org/debian bookworm-updates main non-free-firmware
deb-src http://deb.debian.org/debian bookworm-updates main non-free-firmware
EOF

# Configurar el PATH
echo "Configurando PATH..."
export PATH=$PATH:/usr/local/sbin:/usr/sbin:/sbin

# Actualizar el sistema e instalar paquetes
echo "Actualizando el sistema e instalando paquetes..."
apt update && apt upgrade -y && apt install -y unzip mc net-tools curl docker.io docker-compose || handle_error

# Obtener la IP pública del servidor
SERVER_IP=$(curl -s ipinfo.io/ip)
echo "La IP del servidor es: ${SERVER_IP}"

# Crear directorio para WireGuard
echo "Creando directorio para WireGuard..."
mkdir -p /opt/wireguard-server || handle_error

# Damos permisos al usuario
echo "Dando permisos al usuario..."
chown -R $USER:$USER /opt/wireguard-server || handle_error

# Crear archivo docker-compose.yaml
echo "Configurando WireGuard..."
cat <<EOF > /opt/wireguard-server/docker-compose.yaml
---
services:
  wireguard:
    image: lscr.io/linuxserver/wireguard:latest
    container_name: wireguard
    cap_add:
      - NET_ADMIN
      - SYS_MODULE
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/UTC
      - SERVERURL=${SERVER_IP}
      - SERVERPORT=51820
      - PEERS=50
      - PEERDNS=auto
      - INTERNAL_SUBNET=10.13.13.0
      - ALLOWEDIPS=0.0.0.0/0
      - LOG_CONFS=true
    volumes:
      - /opt/wireguard-server/config:/config
      - /lib/modules:/lib/modules
    ports:
      - 51820:51820/udp
    sysctls:
      - net.ipv4.conf.all.src_valid_mark=1
    restart: unless-stopped
EOF

# Ir al directorio y ejecutar docker-compose
cd /opt/wireguard-server || handle_error
docker-compose up -d || handle_error

# Verificar el estado de WireGuard
docker-compose ps || handle_error

# Ejecutar El Contenedor de Docker
docker exec -it wireguard wg || handle_error
