# ----------------------------------
# Pterodactyl Core Dockerfile
# Environment: Source Engine
# Minimum Panel Version: 0.6.0
# ----------------------------------
FROM        ubuntu:18.04

LABEL       author="Terrahost US" maintainer="support@terrahost.cloud"

ENV         DEBIAN_FRONTEND noninteractive
# Install Dependencies
RUN         dpkg --add-architecture i386 \
            && apt-get update \
            && apt-get upgrade -y \
            && apt-get install -y --no-install-recommends redis-server jq libssl1.0.0 libidn11 librtmp1 libgssapi-krb5-2 libprotobuf10 tar curl gcc g++ iproute2 libfontconfig telnet net-tools \
            && apt-get install -y --no-install-recommends lib32gcc1 wget unzip tzdata ca-certificates \
            && useradd -m -d /home/container container

# Work around for out-of-date SSL library
RUN         cd /usr/lib/x86_64-linux-gnu/ && \
	        ln -s libssl.so.1.1 libssl.so.1.0.0 && \
	        ln -s libcrypto.so.1.1 libcrypto.so.1.0.0

USER        container
ENV         HOME /home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
