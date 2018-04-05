#!/usr/bin/env bash

set -e

script_dir="$( cd "$(dirname "$0")" ; pwd -P )"
project_dir="$(dirname "${script_dir}")"

# shellcheck source=/dev/null
source "${project_dir}/shell-tools/common"

default_spaces=8

check_depends() {
    st_require_command expand
    st_require_command sponge
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
