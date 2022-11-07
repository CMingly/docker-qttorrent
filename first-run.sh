#!/bin/sh

if [ ! -f ${Q_CONFIG_PATH}/initial-run-completed ]; then
  while [ ! -f ${Q_CONFIG_PATH}/qBittorrent/config/lockfile ]
  do
    sleep 0.1
  done

  QBIT_AUTH_COOKIE=`curl -s -H "Referer: http://localhost:${QCONF_Preferences_WebUI__Port}" --data "username=${Q_INITIAL_WEBUI_USERNAME}&password=${Q_INITIAL_WEBUI_PASSWORD}" -c - http://localhost:${QCONF_Preferences_WebUI__Port}/api/v2/auth/login | grep SID | awk '{print $(NF-1)"="$NF}'`

  curl -i -X POST http://localhost:${QCONF_Preferences_WebUI__Port}/api/v2/app/setPreferences -H "Referer: http://localhost:${QCONF_Preferences_WebUI__Port}" --cookie ${QBIT_AUTH_COOKIE} -d 'json={"web_ui_username":"'${QCONF_Preferences_WebUI__Username}'","web_ui_password":"'${QCONF_Preferences_WebUI__Password}'"}'
  curl http://localhost:${QCONF_Preferences_WebUI__Port}/api/v2/auth/logout --cookie ${QBIT_AUTH_COOKIE}

  touch ${Q_CONFIG_PATH}/initial-run-completed
fi
