# Establece la imagen de base a utilizar
FROM debian:bookworm-slim

# Variables de entorno
ENV DEBIAN_FRONTEND noninteractive
ENV TZ=Europe/Madrid

# Directorio de trabajo
RUN mkdir -p /root/workspace

#Fijamos la zona horaria a nivel contendor.
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Actualización imágen de sistema
RUN apt-get update && apt-get -y -o Dpkg::Options::="--force-confold" upgrade

# Instalación de paquetes necesarios para compilar Buildroot
RUN apt-get install -y git build-essential wget cpio python-is-python3 python3 unzip bc mercurial subversion gcc-multilib vim ccache squashfs-tools zip gettext mtools dosfstools libncurses5-dev cmake g++-multilib automake rsync file zlib1g-dev

# Limpieza del gestor de paquetes
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Instalación toolchain
COPY opendingux-gcw0-toolchain.*.tar.xz /opt
RUN tar -xf /opt/opendingux-gcw0-toolchain.*.tar.xz -C /opt
RUN rm /opt/opendingux-gcw0-toolchain.*.tar.xz
RUN /opt/gcw0-toolchain/relocate-sdk.sh

ENV PATH="/opt/gcw0-toolchain/usr/bin:${PATH}:/opt/gcw0-toolchain/usr/mipsel-gcw0-linux-uclibc/sysroot/bin"
ENV CROSS_COMPILE=/opt/gcw0-toolchain/usr/bin/mipsel-gcw0-linux-uclibc-
ENV PREFIX=/opt/gcw0-toolchain/usr/mipsel-gcw0-linux-uclibc/sysroot/usr

# # Configuración de locales
# #RUN locale-gen es_ES.UTF-8
# #RUN update-locale LANG="es_ES.UTF-8" LANGUAGE="es_ES"
# #RUN dpkg-reconfigure locales

VOLUME /root/workspace
WORKDIR /root/workspace

CMD ["/bin/bash"]