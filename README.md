# vpn-wireguard-docker
Este script automatiza la instalación y configuración de un servidor WireGuard utilizando Docker y Docker Compose en un sistema Debian 12 (Bookworm).

Descripción del Script

Este script automatiza la instalación y configuración de un servidor WireGuard utilizando Docker y Docker Compose en un sistema Debian 12 (Bookworm). Incluye los siguientes pasos:

    Configura el archivo sources.list de Debian con los repositorios adecuados.
    Actualiza el sistema e instala los paquetes necesarios.
    Obtiene la IP pública del servidor para configurarla en el contenedor de WireGuard.
    Crea un directorio específico para la configuración de WireGuard.
    Configura un archivo docker-compose.yaml para levantar el servicio de WireGuard en un contenedor Docker.
    Ejecuta y verifica el estado del contenedor.

Paso a Paso para Publicarlo en GitHub

    Crear un Repositorio en GitHub:
        Ve a GitHub y crea un nuevo repositorio.
        Asigna un nombre al repositorio, por ejemplo: wireguard-docker-setup.
        Añade una descripción breve: "Script para automatizar la instalación de WireGuard con Docker en Debian".

    Configurar el Repositorio en tu Máquina Local: Abre tu terminal y ejecuta los siguientes comandos para inicializar un repositorio git en tu directorio de trabajo:

    bash

mkdir wireguard-docker-setup
cd wireguard-docker-setup
git init

Añadir el Script al Repositorio: Crea un archivo para tu script dentro del repositorio:

bash

nano install-wireguard.sh

Luego, copia y pega el contenido de tu script dentro de este archivo. Guarda y cierra el editor.

Añadir el Archivo al Repositorio: Después de crear el script, agrégalo al índice de git y realiza un commit:

bash

git add install-wireguard.sh
git commit -m "Añadir script de instalación de WireGuard con Docker"

Vincular tu Repositorio Local con GitHub: Ejecuta el siguiente comando para vincular el repositorio local con GitHub:

bash

git remote add origin https://github.com/tu-usuario/wireguard-docker-setup.git

Subir el Script a GitHub: Finalmente, sube el contenido a GitHub con el comando:

bash

git push -u origin master

Documentar el Proyecto: Crea un archivo README.md para explicar el uso del script:

bash

nano README.md

Dentro del archivo README.md, puedes incluir una descripción como la siguiente:

markdown

# WireGuard Docker Setup

Este script automatiza la instalación y configuración de un servidor WireGuard usando Docker y Docker Compose en Debian 12 (Bookworm).

## Requisitos

- Debian 12 (Bookworm)
- Docker
- Docker Compose

## Instrucciones de Uso

1. Clona este repositorio:
   ```bash
   git clone https://github.com/tu-usuario/wireguard-docker-setup.git

    Haz ejecutable el script:

    bash

chmod +x install-wireguard.sh

Ejecuta el script como root:

bash

    sudo ./install-wireguard.sh

El script instalará los paquetes necesarios, configurará Docker y levantará un contenedor con WireGuard.

sql


    Guarda y haz un commit de este archivo:

    ```bash
    git add README.md
    git commit -m "Añadir archivo README"
    git push

Con esto, tu script estará disponible en GitHub con una guía clara para su uso.
