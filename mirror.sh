#!/bin/bash
################################################################################
#
# Copyright (C) 2028. Dean Yang
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, version 3.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
################################################################################

PWD_ORG=$(pwd)
REPO="$1"

function run()
{
    local -r cmd="$1"
    echo ">> $cmd"
    eval "$cmd"
    return $?
}

function wait_any_key()
{
    read -n 1 -s -r -p "Press any key to continue"
}

function main()
{
    if [ "$REPO" == "" ]; then
        # shellcheck disable=SC2162
        read -p "Input repository URL: " REPO
    fi

    dir=$(basename "$REPO")

    run "git clone --mirror $REPO"
    ERRNO=$?

    if [[ $REPO =~ http* ]] && [[ $ERRNO -eq 0 ]]; then
        # shellcheck disable=SC2164
        cd "$dir"
        run "git lfs fetch --all"
    fi
}

main
# shellcheck disable=SC2164
cd "$PWD_ORG"

wait_any_key
