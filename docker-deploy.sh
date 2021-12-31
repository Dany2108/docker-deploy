#!/bin/bash

if [ "$1" == "--create" ]; then
    echo "option choisi : $1"

    #Vérifie si $2 est vide
    nb_machine=1
    [ "$2" != "" ] && nb_machine=$2

    for i in $(seq 1 $nb_machine);do
    docker run -tid --name $USER-alpine-$i alpine:latest
    echo "Machine N°$i crée"
    done


elif [ "$1" == "--drop" ]; then
    echo "option choisi : $1"
    docker rm -f $(docker ps -a | grep $USER-alpine | awk '{print $1}')
    echo "les machines ont été supprimé"

elif [ "$1" == "--infos" ]; then
    echo "option choisi : $1"

elif [ "$1" == "--start" ]; then
    echo "option choisi : $1"

elif [ "$1" == "--ansible" ]; then
    echo "option choisi : $1"

else
    echo "
    Options :
        --create : lancer des conteneurs

        --drop : supprimer les conteneurs

        --infos : infos sur les conteneurs (ip, nom, user, ....)

        --start : redémarrer les conteneurs

        --ansible : déploiement arborescence ansible
    "
fi
