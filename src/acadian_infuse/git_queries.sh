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
function get_file_changes () { echo "lines_added,lines_deleted,file_name,author"; authors=(`git --no-pager shortlog -sn --all | col_n 2 | xargs`);for author in ${authors[@]}; do git --no-pager log --author="$author" --format=tformat: --numstat --after "11/12/21" --before "11/20/21" | egrep -v "=>" | sed -E "s/[[:blank:]]+/,/g;s/(.*)/\1,$author/g"; done; }

