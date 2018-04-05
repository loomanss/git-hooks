#!/usr/bin/env bash

set -e

script_dir="$( cd "$(dirname "$0")" ; pwd -P )"
project_dir="$(dirname "${script_dir}")"

# shellcheck source=/dev/null
source "${project_dir}/shell-tools/common"

check_depends() {
    st_require_command shellcheck
}

check_depends
shellcheck "${@}"
