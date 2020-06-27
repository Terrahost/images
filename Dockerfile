# ----------------------------------
# Environment: ubuntu
# Minimum Panel Version: 0.7.X
# ----------------------------------
FROM        debian:buster-slim

LABEL       author="Michael Parker" maintainer="parker@pterodactyl.io"

ENV         DEBIAN_FRONTEND noninteractive

RUN         dpkg --add-architecture i386 \
            && apt-get update \
            && apt-get upgrade -y \
            ## install dependencies 
            && apt-get install -y tar curl gcc g++ libgl1 lib32gcc1 libgcc1 libcurl4-gnutls-dev:i386 libcurl4:i386 libtinfo5 lib32z1 libstdc++6 lib32stdc++6 libncurses5:i386 libcurl3-gnutls:i386 libreadline5 libncursesw5 iproute2 gdb libsdl1.2debian libfontconfig1 telnet net-tools netcat libtcmalloc-minimal4:i386 faketime:i386 locales libmariadbclient-dev \
            ## install rcon-cli
            && curl -sSL https://github.com/itzg/rcon-cli/releases/download/1.4.8/rcon-cli_1.4.8_linux_amd64.tar.gz -o rcon-cli.tar.gz \
            && tar xzf rcon-cli.tar.gz \
            && mv rcon-cli /usr/local/bin/ \
            ## configure locale
            && update-locale lang=en_US.UTF-8 \
            && dpkg-reconfigure --frontend noninteractive locales \
            ## add container user
            && useradd -m -d /home/container container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]