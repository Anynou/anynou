FROM raspbian/stretch:latest
LABEL MAINTAINER="Sr.Anynou"

# Install packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -y install transmission-daemon wget gcc make supervisor
RUN wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-1.5.tar.gz
RUN tar xfvz jq-1.5.tar.gz
RUN cd jq-1.5 && ./configure && make && make install

RUN /etc/init.d/transmission-daemon stop
RUN mkdir -p /srv/torrents/tmp && chown -R debian-transmission:debian-transmission /srv/torrents && find /srv/torrents -type d -print -exec chmod 775 {} \;
RUN find /srv/torrents -type f -print -exec chmod 664 {} \;

ENV SETTINGS=/etc/transmission-daemon/settings.json
ENV TEMPORAL=/etc/transmission-daemon/temporal.json

RUN cp $SETTINGS $SETTINGS.backup
RUN jq '.["download-dir"]'='"/srv/torrents"' $SETTINGS > $TEMPORAL && mv $TEMPORAL $SETTINGS
RUN jq '.["incomplete-dir"]'='"/srv/torrents/tmp"' $SETTINGS > $TEMPORAL && mv $TEMPORAL $SETTINGS
RUN jq '.["rpc-authentication-required"]'='true' $SETTINGS > $TEMPORAL && mv $TEMPORAL $SETTINGS
RUN jq '.["rpc-bind-address"]'='"0.0.0.0"' $SETTINGS > $TEMPORAL && mv $TEMPORAL $SETTINGS
RUN jq '.["rpc-enabled"]'='true' $SETTINGS > $TEMPORAL && mv $TEMPORAL $SETTINGS
RUN jq '.["rpc-password"]'='"TUPASSWORD"' $SETTINGS > $TEMPORAL && mv $TEMPORAL $SETTINGS
RUN jq '.["rpc-port"]'='9091' $SETTINGS > $TEMPORAL && mv $TEMPORAL $SETTINGS
RUN jq '.["rpc-url"]'='"/transmission/"' $SETTINGS > $TEMPORAL && mv $TEMPORAL $SETTINGS
RUN jq '.["rpc-username"]'='"pi"' $SETTINGS > $TEMPORAL && mv $TEMPORAL $SETTINGS
RUN jq '.["rpc-whitelist"]'='"0.0.0.0"' $SETTINGS > $TEMPORAL && mv $TEMPORAL $SETTINGS
RUN jq '.["rpc-whitelist-enabled"]'='false' $SETTINGS > $TEMPORAL && mv $TEMPORAL $SETTINGS

EXPOSE 8080/tcp
EXPOSE 9091/tcp
EXPOSE 9091/udp

COPY supervisord-transmission.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord"]
