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
    for dir in */ ; do
        dir_name=$(dirname "$dir/test")

        echo "########################################"
        echo " $dir_name"
        echo "########################################"

        # shellcheck disable=SC2164
        cd "$PWD_ORG/$dir"

        run "git fetch --prune --prune-tags --tags"

        url=$(git remote get-url origin)
        [[ $url =~ http* ]] && run "git lfs fetch --all"

        echo
    done
}

main
# shellcheck disable=SC2164
cd "$PWD_ORG"

wait_any_key
