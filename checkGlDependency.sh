#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'


#Check for GLFW

glfwState=$(pkg-config --libs glfw3)
if ([ $glfwState == "-lglfw" ]); then
    echo 'true'
else 
    echo -e "${RED}[Error]${NC} : GLFW3 is missing use the following commands to install it :
sudo apt-get install libglfw3
sudo apt-get install libglfw3-dev"
    exit 1
fi
#Check for Xorg presence
xorgState=$(dpkg -s xorg)
dpkgSCheck='Status: install ok installed'
if [[ "$xorgState" == *"$dpkgSCheck"* ]]; then
    echo 'Xorg true'
else 
    echo -e "${RED}[Error]${NC} : Xorg is missing use the following command to install it :
sudo apt install xorg-dev"
    exit 1
fi
#Check for wayland dependency
waylandDependency=('libwayland-dev' 'libxkbcommon-dev' 'wayland-protocols' 'extra-cmake-modules')
missingDependency= false
for i in ${!waylandDependency[@]}; do
    commandResult=$(dpkg -s ${waylandDependency[$i]})
    if [[ "$commandResult" == *"$dpkgSCheck"* ]]; then
        echo "${waylandDependency[$i]} true"
    else echo -e "${RED}[Error]${NC} : ${waylandDependency[$i]} is missing use the following command to install it :
sudo apt install ${waylandDependency[$i]}"
        $missingDependency= true
    fi
done
if ([ $missingDependency = true ]); then 
    exit 1 
fi  