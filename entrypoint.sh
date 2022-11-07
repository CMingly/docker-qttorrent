#!/bin/sh

if [ ! -f ${Q_CONFIG_PATH}/qBittorrent/config/qBittorrent.conf ]; then
  mkdir -p ${Q_CONFIG_PATH}/qBittorrent/config

  echo "[AutoRun]" > ${Q_CONFIG_PATH}/qBittorrent/config/qBittorrent.conf
  printenv | grep ^QCONF_AutoRun_ | while IFS= read -r line; do
    echo "$(echo ${line%%=*} | sed -e "s/^QCONF_AutoRun_//" | sed -e 's/__/\\/g')=${line#*=}" >> ${Q_CONFIG_PATH}/qBittorrent/config/qBittorrent.conf
  done
  echo "" >> ${Q_CONFIG_PATH}/qBittorrent/config/qBittorrent.conf

  echo "[BitTorrent]" >> ${Q_CONFIG_PATH}/qBittorrent/config/qBittorrent.conf
  printenv | grep ^QCONF_BitTorrent_ | while IFS= read -r line; do
    echo "$(echo ${line%%=*} | sed -e "s/^QCONF_BitTorrent_//" | sed -e 's/__/\\/g')=${line#*=}" >> ${Q_CONFIG_PATH}/qBittorrent/config/qBittorrent.conf
  done
  echo "" >> ${Q_CONFIG_PATH}/qBittorrent/config/qBittorrent.conf

  echo "[Core]" >> ${Q_CONFIG_PATH}/qBittorrent/config/qBittorrent.conf
  printenv | grep ^QCONF_Core_ | while IFS= read -r line; do
    echo "$(echo ${line%%=*} | sed -e "s/^QCONF_Core_//" | sed -e 's/__/\\/g')=${line#*=}" >> ${Q_CONFIG_PATH}/qBittorrent/config/qBittorrent.conf
  done
  echo "" >> ${Q_CONFIG_PATH}/qBittorrent/config/qBittorrent.conf

  echo "[Meta]" >> ${Q_CONFIG_PATH}/qBittorrent/config/qBittorrent.conf
  printenv | grep ^QCONF_Meta_ | while IFS= read -r line; do
    echo "$(echo ${line%%=*} | sed -e "s/^QCONF_Meta_//" | sed -e 's/__/\\/g')=${line#*=}" >> ${Q_CONFIG_PATH}/qBittorrent/config/qBittorrent.conf
  done
  echo "" >> ${Q_CONFIG_PATH}/qBittorrent/config/qBittorrent.conf

  echo "[Network]" >> ${Q_CONFIG_PATH}/qBittorrent/config/qBittorrent.conf
  printenv | grep ^QCONF_Network_ | while IFS= read -r line; do
    echo "$(echo ${line%%=*} | sed -e "s/^QCONF_Network_//" | sed -e 's/__/\\/g')=${line#*=}" >> ${Q_CONFIG_PATH}/qBittorrent/config/qBittorrent.conf
  done
  echo "" >> ${Q_CONFIG_PATH}/qBittorrent/config/qBittorrent.conf

  echo "[Preferences]" >> ${Q_CONFIG_PATH}/qBittorrent/config/qBittorrent.conf
  printenv | grep ^QCONF_Preferences_ | while IFS= read -r line; do
    if ! { [ "${line%%=*}" == "QCONF_Preferences_WebUI__Username" ] || [ "${line%%=*}" == "QCONF_Preferences_WebUI__Password" ]; }; then
      echo "$(echo ${line%%=*} | sed -e "s/^QCONF_Preferences_//" | sed -e 's/__/\\/g')=${line#*=}" >> ${Q_CONFIG_PATH}/qBittorrent/config/qBittorrent.conf
    fi
  done
  echo "" >> ${Q_CONFIG_PATH}/qBittorrent/config/qBittorrent.conf

  echo "[RSS]" >> ${Q_CONFIG_PATH}/qBittorrent/config/qBittorrent.conf
  printenv | grep ^QCONF_RSS_ | while IFS= read -r line; do
    echo "$(echo ${line%%=*} | sed -e "s/^QCONF_RSS_//" | sed -e 's/__/\\/g')=${line#*=}" >> ${Q_CONFIG_PATH}/qBittorrent/config/qBittorrent.conf
  done
  echo "" >> ${Q_CONFIG_PATH}/qBittorrent/config/qBittorrent.conf
fi

/first-run.sh &

find ${C_CUSTOMSCRIPTS_PATH} -type f -print0 | sort -zn | xargs -0 -I '{}' /bin/sh '{}'

qbittorrent-nox --webui-port=${QCONF_Preferences_WebUI__Port} --profile=${Q_CONFIG_PATH}
