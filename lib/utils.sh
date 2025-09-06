#!/bin/bash

function print_usage() {
    printf "\nиспользование: ${_LWHT}build.sh <режим>${_NA}\n\n"
    printf "${_LWHT}\t<режим> ${_WHT}- режим сборки, поддерживаемые режимы:${_NA}\n\n"
    printf "${_LWHT}\t\t clean ${_WHT}- удалить образы, вернуть дерево сборки в изначальное состояние${_NA}\n"
    printf "${_LWHT}\t\t image ${_WHT}- собрать образ и загрузить его в docker${_NA}\n"
    printf "\n"
}

# show errror message ($1) and exit with exit code #############################
# calculated from error message hash
function error_exit() {
    printf "\n\n${_LRED}$1${_NA}\n\n"
    exit_code=$(echo $1 | sum -s | awk '{ print $1 }')
    exit $exit_code
}
################################################################################
