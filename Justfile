# vim: set filetype=bash :

create-venv:
  python -m venv ~/.virtualenvs/pandas_data_analytics;
 
start-venv-windows:
  . $HOME/.virtualenvs/pandas_data_analytics/Scripts/activate;

start-venv:
  . $HOME/.virtualenvs/pandas_data_analytics/bin/activate;

stop-venv:
  deactivate;

install-pip-deps:
  pip install wheel; pip install -e .;

first-time-initialize:
  #!/usr/bin/env bash
  set -euxo pipefail
  just create-venv;
  just start-venv;
  just install-pip-deps;

format:
  autopep8 . && echo "Projected Formated!" || { echo "Failed to format project!"; exit 1; }

start-container:
  docker-compose -f .devcontainer/docker-compose.yaml up -d;

stop-container:
  docker-compose -f .devcontainer/docker-compose.yaml stop;

connect-to-container CONTAINER_NAME='devcontainer_pandas_data_analytics_app_1':
  docker exec -it "{{CONTAINER_NAME}}" /bin/bash;

