#!/bin/bash
set -o nounset -o errexit

CONF_DIR="$HOME/.jupyter"
CONF_FILE="${CONF_DIR}/jupyter_notebook_config.py"
mkdir -p "${CONF_DIR}"

PREFIX=/${DOMINO_PROJECT_OWNER}/${DOMINO_PROJECT_NAME}/notebookSession/${DOMINO_RUN_ID}/

cat >> $CONF_FILE << EOF
c = get_config()
c.NotebookApp.notebook_dir = '/'
c.NotebookApp.base_url = '${PREFIX}'
c.NotebookApp.tornado_settings = {'headers': {'Content-Security-Policy': 'frame-ancestors *'}, 'static_url_prefix': '${PREFIX}static/'}
c.NotebookApp.default_url = '/lab/tree${DOMINO_WORKING_DIR}'
c.NotebookApp.token = u''
c.ServerProxy.servers = {
    "Tensorboard": {
        'command': ['configurable-http-proxy', '--ip', '127.0.0.1', '--port', '{port}', '--default-target=http://127.0.0.1:6006/${DOMINO_PROJECT_OWNER}/${DOMINO_PROJECT_NAME}/notebookSession/${DOMINO_RUN_ID}/Tensorboard/']
    }
}
EOF

jupyter-lab --config="$CONF_FILE" --no-browser --ip="0.0.0.0" 2>&1

