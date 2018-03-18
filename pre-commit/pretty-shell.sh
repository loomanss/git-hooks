#!/usr/bin/env bash

set -e

require_command() {
    if [ ! "$(command -v "${1}")" ]; then
        printf "%s required, but not installed\n" "${1}"
        exit 1
    fi
}

check_depends() {
    require_command shellcheck
}

check_depends
shellcheck "${@}"
