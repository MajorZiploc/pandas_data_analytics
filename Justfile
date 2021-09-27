# vim: set filetype=bash :

create-venv:
  python -m venv ~/.virtualenvs/pandas_data_analytics;
 
start-venv:
  source $HOME/.virtualenvs/pandas_data_analytics/Scripts/activate;

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

