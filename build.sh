#!/bin/bash

if [[ -n $DCK1C_ROOT ]]; then
    export BASEDIRECTORY=$DCKESB_ROOT
else
    export BASEDIRECTORY=$(dirname $0)
fi

if [[ ! -f $BASEDIRECTORY/lib/utils.sh ]]; then
    printf "\n\n"
    printf "Текущая директория не является базовой директорией dckseb\n"
    printf "Запускайте скрипты перейдя в базовую директорию\n"
    printf "или установите переменную окружения DCKESB_ROOT\n"
    printf "к примеру: export DCKESB_ROOT=/opt/dckesb\n"
    printf "\n\n"
    exit -1
fi

source $BASEDIRECTORY/lib/ansiesc.sh
source $BASEDIRECTORY/lib/utils.sh

################################################################################

if [[ -z $1 ]]; then
    print_usage
    exit 0
fi

if [[ $1 != "clean" ]] && [[ $1 != "image" ]] ; then
    error_exit "Ошибка в параметрах коммандной строки, запустите без параметров чтобы увидеть справку об использовании"
fi

if [[ $1 == "clean" ]]; then
    printf "${_LWHT}Сleanup build tree...${_NA}\n"
    rm -rf ./build/
    printf "${_LGRN}Done.${_NA}\n"
    exit 0
fi

################################################################################

printf "${_LWHT}Building the image...${_NA}\n"

mkdir -p ./build/esb

printf "${_WHT}unpacking 1C:ESB distribution kit${_NA}\n"
find ./distr -name "*esb*.tar.gz" -print0 | xargs -0 -I {} tar -zxf {} -C ./build/esb

printf "${_WHT}start of build${_NA}\n"
cp ./dckesb.Dockerfile ./build/Dockerfile
cd ./build
docker build -t esb .

printf "${_LGRN}Done.${_NA}\n"


