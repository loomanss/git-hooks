#!/usr/bin/env bash

set -e

default_config=".uncrustify"

require_command() {
    if [ ! "$(command -v "${1}")" ]; then
        printf "%s %s\\n" "${1}" "required, but not installed"
        exit 1
    fi
}

check_depends() {
    require_command uncrustify
}

check_depends

while [[ $# -gt 0 ]]; do
    case "${1}" in
        -c|--config) cli_config="${2}"; shift ;;
        --config=*) cli_config=$(echo "${1}" | cut -d'=' -f2) ;;
        *) newparams+=("${1}") ;;
    esac
    shift
done

set -- "${newparams[@]}"

if [ -z "${cli_config}" ]; then
    config="${default_config}"
else
    config="${cli_config}"
fi

if [ -f "${config}" ]; then
    for file in "${@}"
    do
        uncrustify              \
        -l C                    \
        -c "${config}"          \
        --no-backup             \
        "${file}"
    done
else
    printf "Could not find config file"
    exit 1
fi
