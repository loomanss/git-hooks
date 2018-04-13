#!/usr/bin/env bash

set -e

script_dir="$( cd "$(dirname "$0")" ; pwd -P )"
project_dir="$(dirname "${script_dir}")"

# shellcheck source=/dev/null
source "${project_dir}/shell-tools/common"

check_depends() {
    st_require_command sponge
}

convert_win1252_encoding() {
    iconv                       \
    -f WINDOWS-1252             \
    -t UTF-8                    \
    "${1}"                      \
    | sponge "${1}"

    printf "%s %s %s\\n" "INFO: Check" "${1}" "for correct encoding after conversion"
}

check_depends

while [[ $# -gt 0 ]]; do
    case "${1}" in
        *) newparams+=("${1}") ;;
    esac
    shift
done

set -- "${newparams[@]}"

for file in "${@}"
do
    file_encoding=$(st_get_file_encoding "${file}")

    if [ "${file_encoding}" = "unknown-8bit" ]; then
        # The file is most likely encoded with the Windows 1252 scheme
        convert_win1252_encoding "${file}"
    fi
done
