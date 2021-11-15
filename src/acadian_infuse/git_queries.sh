#!/usr/bin/env bash

# num of commits on current branch
git --no-pager log --oneline | wc -l

# num of commits for all branch
git --no-pager log --oneline --all | wc -l

# num of commits for each author for all branches
git --no-pager shortlog -sn --all

git --no-pager shortlog -sn --all --after "10/1/21" --before "11/31/21"

