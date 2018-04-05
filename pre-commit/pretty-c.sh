#!/usr/bin/env bash

set -e

script_dir="$( cd "$(dirname "$0")" ; pwd -P )"
project_dir="$(dirname "${script_dir}")"

# shellcheck source=/dev/null
source "${project_dir}/shell-tools/common"

default_config=".uncrustify"

check_depends() {
    st_require_command uncrustify
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
