FROM cmingly/base-alpine:0.3

USER root

ENV Q_CONFIG_PATH=/etc/qbittorrent
ENV Q_INITIAL_WEBUI_USERNAME=admin
ENV Q_INITIAL_WEBUI_PASSWORD=adminadmin

ENV QCONF_BitTorrent_Session__DefaultSavePath=/opt/downloads
ENV QCONF_BitTorrent_Session__TempPath=/tmp/downloads

ENV QCONF_Preferences_WebUI__Username=admin
ENV QCONF_Preferences_WebUI__Password=adminadmin
ENV QCONF_Preferences_WebUI__Port=8080

RUN apk add -U --update --no-cache curl qbittorrent-nox

RUN mkdir -p ${Q_CONFIG_PATH} && chown -R ${C_UID}:${C_GID} ${Q_CONFIG_PATH}
RUN mkdir -p ${QCONF_BitTorrent_Session__DefaultSavePath} && chown -R ${C_UID}:${C_GID} ${QCONF_BitTorrent_Session__DefaultSavePath}
RUN mkdir -p ${QCONF_BitTorrent_Session__TempPath} && chown -R ${C_UID}:${C_GID} ${QCONF_BitTorrent_Session__TempPath}

USER ${C_USER}

COPY ./first-run.sh /first-run.sh
COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
