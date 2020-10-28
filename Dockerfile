# ----------------------------------
# Pterodactyl Core Dockerfile
# Environment: glibc
# Minimum Panel Version: 0.6.0
# ----------------------------------
FROM        node:15-buster-slim

LABEL       author="Terrahost" maintainer="opensource@terrahost.cloud"

RUN         curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - \
            echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

RUN         apt update \
            && apt -y install yarn ffmpeg iproute2 git sqlite3 python3 ca-certificates dnsutils build-essential \
            && useradd -m -d /home/container container


USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
