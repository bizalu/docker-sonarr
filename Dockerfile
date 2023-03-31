FROM lscr.io/linuxserver/sonarr:latest
LABEL Maintainer="bizalu"

# Prepare python environment
ENV PYTHONUNBUFFERED=1
RUN apt-get install -y python3
RUN if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi
RUN apt-get clean

# Install custom post files
COPY services/ /etc/s6-overlay/s6-rc.d/
RUN find /etc/s6-overlay/s6-rc.d/ -name run -exec chmod u+x {} \;

# Install custom post script
COPY custom-script/ /etc/cont-post.d/
RUN chmod u+x /etc/cont-post.d/*