tensorboard \
 --host 127.0.0.1 \
 --port 6006 \
 --logdir /domino/datasets/${DOMINO_STARTING_USERNAME}/${DOMINO_PROJECT_NAME}/scratch/tensorboard_logs \
 --path_prefix /${DOMINO_PROJECT_OWNER}/${DOMINO_PROJECT_NAME}/notebookSession/${DOMINO_RUN_ID}/Tensorboard &

cat << EOF >> /home/ubuntu/.jupyter/jupyter_notebook_config.py
c.ServerProxy.servers = {
    "Tensorboard": {
        'command': ['configurable-http-proxy', '--ip', '127.0.0.1', '--port', '{port}', '--default-target=http://127.0.0.1:6006/${DOMINO_PROJECT_OWNER}/${DOMINO_PROJECT_NAME}/notebookSession/${DOMINO_RUN_ID}/Tensorboard/']
    }
}
EOF
