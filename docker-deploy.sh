#!/bin/bash

if [ "$1" == "--create" ]; then
    echo "option choisi : $1"

    #Vérifie si $2 est vide
    nb_machine=1
    [ "$2" != "" ] && nb_machine=$2

    last_id=`docker ps -a --format '{{ .Names }}' | awk -F "-" -v user=$USER '$0 ~ user"-alpine" {print $3}' | sort -r | head -1`
    echo "Déjà $last_id conteneurs sont lancés"

    for ((i=$(($last_id + 1)); i<$(($nb_machine + $last_id + 1)); i++))
    do
    docker run -tid --name $USER-alpine-$i alpine:latest
    echo "Conteneur N°$i créé"
    done


elif [ "$1" == "--drop" ]; then
    echo "option choisi : $1"
    docker rm -f $(docker ps -a | grep $USER-alpine | awk '{print $1}')
    echo "les conteneurs ont été supprimé"

elif [ "$1" == "--infos" ]; then
    echo "option choisi : $1"
    for conteneur in $(docker ps -a | grep $USER-alpine | awk '{print $1}');do
        docker inspect -f ' => {{.Name}} - {{.NetworkSettings.IPAddress }}' $conteneur
    done

elif [ "$1" == "--start" ]; then
    echo "option choisi : $1"

    nb_machine=`docker ps -a --format '{{ .Names }}' | awk -F "-" -v user=$USER '$0 ~ user"-alpine" {print $3}' | sort -r | head -1`
    echo "ils existent $nb_machine conteneurs"
    echo "Démarrage en cours ..."

    for ((i=1; i<$(($nb_machine + 1)); i++))
    do
    docker start $USER-alpine-$i 
    echo "Le conteneur $USER-alpine-$i a bien été démarré"
    done    
    
    #docker start $(docker ps -a | grep $USER-alpine | awk '{print $1}')

elif [ "$1" == "--stop" ]; then
    echo "option choisi : $1"

    nb_machine=`docker ps -a --format '{{ .Names }}' | awk -F "-" -v user=$USER '$0 ~ user"-alpine" {print $3}' | sort -r | head -1`
    echo "$nb_machine conteneurs sont lancés"


    for ((i=1; i<$(($nb_machine + 1)); i++))
    do
    docker stop $USER-alpine-$i 
    echo "Le conteneur $USER-alpine-$i a bien été stoppé"
    done

elif [ "$1" == "--ansible" ]; then
    echo "option choisi : $1"

else
    echo "
    Options :
        --create : lancer des conteneurs

        --drop : supprimer les conteneurs

        --infos : infos sur les conteneurs (ip, nom, user, ....)

        --start : redémarrer les conteneurs

        --stop : arréter les conteneurs

        --ansible : déploiement arborescence ansible
    "
fi
