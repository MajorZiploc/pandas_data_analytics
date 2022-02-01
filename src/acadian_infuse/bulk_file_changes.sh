#!/usr/bin/env bash

. ~/.bashrc;
. ~/.virtualenvs/pandas_data_analytics/bin/activate

function get_file_changes {
  local open_date="$1";
  local end_date="$2";
  [[ -z "$open_date" ]] && { echo "Must specify open_date!" >&2; return 1; }
  [[ -z "$end_date" ]] && { echo "Must specify end_date!" >&2; return 1; }
  local to_comma='s/[[:blank:]]+/,/';
  echo "lines_added,lines_deleted,file_name,author";
  authors=(`git --no-pager shortlog -sn --all | col_n 2 | xargs`);
  for author in ${authors[@]}; do
    git --no-pager log --all --author="$author" --format=tformat: --numstat --after "$open_date" --before "$end_date" | egrep -v "=>" | sed -E "$to_comma;$to_comma;s/(.*)/\1,$author/" | perl -F'' -nle 'print if scalar(grep(/,/,@F)) == 3';
  done;
}

function main {
  local script_path=`show_script_path`;
  # sunday to sunday
  local date_ranges=("10/03/21~10/10/21" "10/10/21~10/17/21" "10/17/21~10/24/21" "10/24/21~10/31/21" "10/31/21~11/07/21" "11/07/21~11/14/21" "11/14/21~11/21/21" "11/21/21~11/28/21" "11/28/21~12/12/21" "12/12/21~12/19/21" "12/19/21~12/26/21" "12/26/21~01/02/22" "01/02/22~01/09/22" "01/09/22~01/16/22");
  for date_range in ${date_ranges[@]}; do
    local open_date=`echo "$date_range" | sed -E 's,(.*)~(.*),\1,g'`;
    local end_date=`echo "$date_range" | sed -E 's,(.*)~(.*),\2,g'`;
    local open_date_file_name=`echo "$open_date" | tr "/" "_"`;
    local end_date_file_name=`echo "$end_date" | tr "/" "_"`;
    echo "------------------------";
    echo "Stats for the date range: $open_date - $end_date";
    cd ~/projects_infuse/acadian-nemt;
    local raw_loc="$script_path/data/infuse/raw/changes_${open_date_file_name}__${end_date_file_name}.csv";
    get_file_changes > "$raw_loc" "$open_date" "$end_date";
    cd ~-;
    local raw_loc="data/infuse/raw/changes_${open_date_file_name}__${end_date_file_name}.csv";
    local cleaned_loc="data/infuse/cleaned/changes_${open_date_file_name}__${end_date_file_name}.csv";
    local config_file="$script_path/config.toml";
    local clean_script="$script_path/clean_file_changes.py";
    local case_study_script="$script_path/case_study.py";
    sed -E -i'' "s,(file_locations.file_changes_raw = )(.*),\1\"${raw_loc}\",g" "$config_file";
    sed -E -i'' "s,(file_locations.file_changes_cleaned = )(.*),\1\"${cleaned_loc}\",g" "$config_file";
    sed -E -i'' "s,(file_locations.case_study = )(.*),\1\"${cleaned_loc}\",g" "$config_file";
    python "$clean_script"
    python "$case_study_script"
    echo "------------------------";
  done;
}

main

