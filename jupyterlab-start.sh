#!/bin/bash

CONF_DIR="${HOME}/.jupyterlab"
CONF_FILE="${CONF_DIR}/jupyter_lab_config.py"
PREFIX=/${DOMINO_PROJECT_OWNER}/${DOMINO_PROJECT_NAME}/notebookSession/${DOMINO_RUN_ID}/

sudo mkdir -p "${CONF_FILE%/*}" 
sudo chown -R ubuntu:ubuntu ${CONF_DIR}

printf "c.ServerApp.notebook_dir='/'
# The default cell execution timeout in nbconvert is 30 seconds, set it to a year
c.ExecutePreprocessor.timeout=365*24*60*60
c.LabApp.default_url='/lab/tree${DOMINO_WORKING_DIR}'
c.ServerApp.base_url='${PREFIX}'
c.ServerApp.tornado_settings={'headers': {'Content-Security-Policy': 'frame-ancestors *'}, 'static_url_prefix': '${PREFIX}static/'}
c.ServerApp.token=u''
c.NotebookApp.iopub_data_rate_limit=10000000000" >> ${CONF_FILE}

jupyter-lab --config="${CONF_FILE}" --no-browser --ip="0.0.0.0" 2>&1
