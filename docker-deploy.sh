#!/bin/bash
prenom="daniel"
test=0

case ${prenom} in
    *da*) test=0;;
    *) test=1;;
esac

echo $test