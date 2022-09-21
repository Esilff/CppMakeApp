#!/bin/bash

addGlDep=''

while [[ true ]]; 
do
    read -p '[y/n] : ' addGlDep
    if [[ $addGlDep = "y" || $addGlDep = "yes" ]]; then
        echo "GL"
        exit 0
    elif [[ $addGlDep = "n" || $addGlDep = "no" ]]; then
        echo "noGL"
        exit 0
    else 
        echo "Wrong input, please retry."
    fi
done  
