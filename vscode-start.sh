#!/bin/bash

SETTINGS_DIR=${DOMINO_WORKING_DIR}/.vscode
FILE=${SETTINGS_DIR}/settings.json

# Add a user setting file if it doesn't exist. Add in DOMINO_WORKING_DIR so it persists across sessions
if [ ! -f "$FILE" ]; then

sudo mkdir -p ${FILE%/*}
sudo chown -R ubuntu:ubuntu ${SETTINGS_DIR} 

printf "{
\t\"extensions.autoUpdate\":false,
\t\"extensions.autoCheckUpdates\": false,
\t\"python.pythonPath\": \"$(which python)\",
\t\"workbench.startupEditor\": \"none\",
\t\"workbench.colorTheme\": \"Default Dark+\"
}\n" > ${FILE}

fi

code-server ${DOMINO_WORKING_DIR} --user-data-dir ${SETTINGS_DIR} --auth none --bind-addr 0.0.0.0:8888 --extensions-dir ${HOME}/.local/share/code-server/extensions --disable-telemetry
