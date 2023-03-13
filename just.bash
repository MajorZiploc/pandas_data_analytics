export JUST_PROJECT_ROOT="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
export VIRTUAL_ENV="$JUST_PROJECT_ROOT/.venv/bin/python";

function just_venv_create {
  python3 -m venv "$JUST_PROJECT_ROOT/.venv";
}

function just_venv_install_pip_deps {
  pip3 install wheel; pip3 install -e "$JUST_PROJECT_ROOT";
}

function just_first_time_initialize_windows {
  just_first_time_initialize_generic 'win';
}

function just_first_time_initialize {
  just_first_time_initialize_generic
}

function just_venv_connect_win {
  . "$JUST_PROJECT_ROOT/.venv/Scripts/activate";
}

function just_venv_connect {
  . "$JUST_PROJECT_ROOT/.venv/bin/activate";
}

function just_venv_disconnect {
  deactivate;
}

function just_first_time_initialize_generic {
  local os="$1";
  just_venv_create;
  if [[ "$os" = "win" ]]; then
    . "$JUST_PROJECT_ROOT/.venv/Scripts/activate";
  else
    . "$JUST_PROJECT_ROOT/.venv/bin/activate";
  fi
  just_venv_install_pip_deps;
}

function just_format {
  autopep8 "$JUST_PROJECT_ROOT";
}

function just_docker_container_start {
  docker-compose -f "${JUST_PROJECT_ROOT}/docker-compose.yaml" up -d;
}

function just_docker_container_stop {
  docker-compose -f "${JUST_PROJECT_ROOT}/docker-compose.yaml" stop;
}

function just_docker_container_connect {
  local container_name="$1";
  container_name="${container_name:-"devcontainer_pandas_data_analytics_app_1"}";
  docker exec -it "$container_name" /bin/bash;
}

function just_clean {
  rm -rf "$JUST_PROJECT_ROOT/.venv";
}

