#!/usr/bin/env bash

# num of commits on current branch
git --no-pager log --oneline | wc -l

# num of commits for all branch
git --no-pager log --oneline --all | wc -l

# num of commits for each author for all branches
git --no-pager shortlog -sn --all

git --no-pager shortlog -sn --all --after "10/1/21" --before "11/31/21"

. ~/.bashrc

# get file changes by each author per file, per commit. file will occur multi times. need to write python pandas code to agg the data on file name
# filter out lines that contain more that 3 commas (may removes files with spaces for the stats, the 2 to_comma subs should allow for finding files with spaces, making the perl command just an extra redundant check for commas)
function get_file_changes () { to_comma='s/[[:blank:]]+/,/';echo "lines_added,lines_deleted,file_name,author"; authors=(`git --no-pager shortlog -sn --all | col_n 2 | xargs`);for author in ${authors[@]}; do git --no-pager log --all --author="$author" --format=tformat: --numstat --after "11/12/21" --before "11/20/21" | egrep -v "=>" | sed -E "$to_comma;$to_comma;s/(.*)/\1,$author/" | perl -F'' -nle 'print if scalar(grep(/,/,@F)) == 3'; done; }

function run_get_files_changes_on_dirs_in_dir () { raw_write_loc="$HOME/projects/pandas_data_analytics/src/acadian_infuse/data/personal_projects/raw"; find . -mindepth 1 -maxdepth 1 -type d -print0 | while read -d $'\0' proj; do cd "$proj"; get_file_changes | tee "$raw_write_loc/$(echo "$proj" | sed -E 's/^\.//')"; cd ..; done; }

function clean_files_changes () { path_prefix="personal_projects";py_proj="$HOME/projects/pandas_data_analytics/src/acadian_infuse"; sed -E -i'' "s,(file_locations.file_changes_raw = \"data/).*\",\1/$path_prefix/raw$1\"," "$py_proj/config.toml"; sed -E -i'' "s,(file_locations.file_changes_cleaned = \"data/).*\",\1/$path_prefix/cleaned$1\"," "$py_proj/config.toml"; python "$py_proj/clean_file_changes.py"; }

function run_cleaning_on_raw_files_in_dir () { find . -type f -print0 | while read -d $'\0' data_file_to_clean; do clean_files_changes "`echo "$data_file_to_clean" | sed -E 's/^\.//'`"; done; }

function get_current_file_stats () { { echo 'line_count,word_count,character_count,file_name'; gfind_files '.*' '' '' 3 | xargs wc -lwc | egrep -vi ' total' | sort -n | trim | sed -E 's/[[:blank:]]+/,/g' | perl -F'' -nle 'print if scalar(grep(/,/,@F)) == 3'; } }

