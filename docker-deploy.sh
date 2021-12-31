#!/bin/bash

if [ "$1" == "--create" ]; then
    echo "option choisi : $1"

    #Vérifie si $2 est vide
    nb_machine=1
    [ "$2" != "" ] && nb_machine=$2

    last_id=`docker ps -a --format '{{ .Names }}' | awk -F "-" -v user=$USER '$0 ~ user"-alpine" {print $3}' | sort -r | head -1`
    echo "Déjà $last_id conteneurs sont lancées"

    for ((i=$(($last_id + 1)); i<$(($nb_machine + $last_id + 1)); i++))
    do
    docker run -tid --name $USER-alpine-$i alpine:latest
    echo "Conteneur N°$i crée"
    done


elif [ "$1" == "--drop" ]; then
    echo "option choisi : $1"
    docker rm -f $(docker ps -a | grep $USER-alpine | awk '{print $1}')
    echo "les conteneurs ont été supprimé"

elif [ "$1" == "--infos" ]; then
    echo "option choisi : $1"

elif [ "$1" == "--start" ]; then
    echo "option choisi : $1"
    docker start $(docker ps -a | grep $USER-alpine | awk '{print $13}')

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
