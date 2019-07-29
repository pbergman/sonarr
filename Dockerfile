FROM mono:6-slim

RUN apt-get update \
  && apt-get install -y --no-install-recommends gnupg dirmngr \
  && rm -rf /var/lib/apt/lists/* \
  && export GNUPGHOME="$(mktemp -d)" \
  && gpg --batch --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys A236C58F409091A18ACA53CBEBFF6B99D9B78493 \
  && gpg --batch --export --armor A236C58F409091A18ACA53CBEBFF6B99D9B78493 > /etc/apt/trusted.gpg.d/sonarr.gpg.asc \
  && gpgconf --kill all \
  && rm -rf "$GNUPGHOME" \
  && apt-key list | grep NzbDrone \
  && apt-get purge -y --auto-remove gnupg dirmngr \
  && mkdir -p /usr/lib/nzbdrone/{config,downloads,tv}


RUN echo "deb http://apt.sonarr.tv/ master main" > /etc/apt/sources.list.d/sonarr-stable.list \
  && apt-get update \
  && apt-get install -y --no-install-recommends nzbdrone \
  && rm -rf /var/lib/apt/lists/* /tmp/*
  
EXPOSE 8989
VOLUME ["/usr/lib/nzbdrone/config", "/usr/lib/nzbdrone/downloads", "/usr/lib/nzbdrone/tv"]

ENTRYPOINT ["mono", "--debug", "/opt/NzbDrone/NzbDrone.exe", "-nobrowser", "-data=/usr/lib/nzbdrone/config"]