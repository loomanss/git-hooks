#!/usr/bin/env bash

set -e

default_spaces=8

require_command() {
    if [ ! "$(command -v "${1}")" ]; then
        printf "%s %s\\n" "${1}" "required, but not installed"
        exit 1
    fi
}

check_depends() {
    require_command expand
    require_command sponge
}

check_depends

while [[ $# -gt 0 ]]; do
    case "${1}" in
        -s|--spaces) cli_spaces="${2}"; shift ;;
        --spaces=*) cli_spaces=$(echo "${1}" | cut -d'=' -f2) ;;
        *) newparams+=("${1}") ;;
    esac
    shift
done

set -- "${newparams[@]}"

if [ -z "${cli_spaces}" ]; then
    spaces="${default_spaces}"
else
    spaces="${cli_spaces}"
fi

for file in "${@}"
do
    expand                      \
    -t "${spaces}"              \
    "${file}" | sponge "${file}"
done
