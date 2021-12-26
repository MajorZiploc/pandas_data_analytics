export PANDAS_DATA_ANALYTICS_PROJECT_ROOT="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

function just_venv_create {
  python -m venv ~/.virtualenvs/pandas_data_analytics;
}

function just_venv_install_pip_deps {
  pip install wheel; pip install -e "$PANDAS_DATA_ANALYTICS_PROJECT_ROOT";
}

function just_first_time_initialize_windows {
  just_first_time_initialize_generic 'win';
}

function just_first_time_initialize {
  just_first_time_initialize_generic
}

function just_venv_connect_win {
  . $HOME/.virtualenvs/pandas_data_analytics/Scripts/activate;
}

function just_venv_connect {
  . $HOME/.virtualenvs/pandas_data_analytics/bin/activate;
}

function just_venv_disconnect {
  deactivate;
}

function just_first_time_initialize_generic {
  local os="$1";
  just_venv_create;
  if [[ "$os" = "win" ]]; then
    . $HOME/.virtualenvs/pandas_data_analytics/Scripts/activate;
  else
    . $HOME/.virtualenvs/pandas_data_analytics/bin/activate;
  fi
  just_venv_install_pip_deps;
}

function just_format {
  autopep8 "$PANDAS_DATA_ANALYTICS_PROJECT_ROOT" && echo "Projected Formated!" || { echo "Failed to format project!"; exit 1; }
}

function just_docker_container_start {
  docker-compose -f "${PANDAS_DATA_ANALYTICS_PROJECT_ROOT}/.devcontainer/docker-compose.yaml" up -d;
}

function just_docker_container_stop {
  docker-compose -f "${PANDAS_DATA_ANALYTICS_PROJECT_ROOT}.devcontainer/docker-compose.yaml" stop;
}

function just_docker_container_connect {
  local container_name="$1";
  container_name="${container_name:-"devcontainer_pandas_data_analytics_app_1"}";
  docker exec -it "$container_name" /bin/bash;
}

