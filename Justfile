# vim: set filetype=bash :

create-venv:
  python -m venv ~/.virtualenvs/pandas_data_analytics;

stop-venv:
  deactivate;

install-pip-deps:
  pip install wheel; pip install -e .;

first-time-initialize-windows:
  just first-time-initialize-generic 'win';

first-time-initialize:
  just first-time-initialize-generic

first-time-initialize-generic OS='':
  #!/usr/bin/env bash
  set -euxo pipefail
  just create-venv;
  if [[ '{{OS}}' = 'win' ]]; then
    . $HOME/.virtualenvs/pandas_data_analytics/Scripts/activate;
  else
    . $HOME/.virtualenvs/pandas_data_analytics/bin/activate;
  fi
  just install-pip-deps;

format:
  autopep8 . && echo "Projected Formated!" || { echo "Failed to format project!"; exit 1; }

start-container:
  docker-compose -f .devcontainer/docker-compose.yaml up -d;

stop-container:
  docker-compose -f .devcontainer/docker-compose.yaml stop;

connect-to-container CONTAINER_NAME='devcontainer_pandas_data_analytics_app_1':
  docker exec -it "{{CONTAINER_NAME}}" /bin/bash;

