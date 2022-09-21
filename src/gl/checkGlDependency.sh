#!/bin/bash

RED='\033[0;31m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

#Check if echoes should be ignored, for now it's only used in setupGlProject.sh
#because not ignoring echoes is causing an exit 127 with the color codes.
ignoreEcho=false
if [[ $1 = '-i' ]]; then
    ignoreEcho=true
fi
#Check for GLFW
if [[ $ignoreEcho = false ]]; then
echo -e "${YELLOW}Checking for GLFW dependency${NC}"
fi
pkg-config --libs glfw3 > ./glfwCheck.txt 2>&1
glfwCheck=$(<glfwCheck.txt)
rm glfwCheck.txt
if [[ $glfwCheck == "-lglfw" ]]; then
    if [[ $ignoreEcho = false ]]; then
        echo -e "${CYAN}[Dependency] : GLFW checked.${NC}"
    fi
else 
    if [[ $ignoreEcho = false ]]; then
        echo -e "${RED}[Error]${NC} : GLFW3 is missing use the following commands to install it :
sudo apt-get install libglfw3
sudo apt-get install libglfw3-dev"
    fi
    exit 1
fi
#Check for Xorg presence
if [[ $ignoreEcho = false ]]; then
    echo -e "${YELLOW}Checking for Xorg dependency${NC}"
fi
dpkg -s xorg > ./xorgState.txt 2>&1
xorgState=$(<xorgState.txt)
rm xorgState.txt
dpkgSCheck='Status: install ok installed'
if [[ "$xorgState" == *"$dpkgSCheck"* ]]; then
    if [[ $ignoreEcho = false ]]; then
        echo -e "${CYAN}[Dependency] : Xorg checked.${NC}"
    fi
else 
    if [[ $ignoreEcho = false ]]; then
        echo -e "${RED}[Error]${NC} : Xorg is missing use the following command to install it :
sudo apt install xorg-dev"
    fi
    exit 1
fi
#Check for wayland dependency
if [[ $ignoreEcho = false ]]; then
    echo -e "${YELLOW}Checking for Wayland dependencies.${NC}"
fi
waylandDependency=('libwayland-dev' 'libxkbcommon-dev' 'wayland-protocols' 'extra-cmake-modules')
missingDependency= false
for i in ${!waylandDependency[@]}; do
    dpkg -s ${waylandDependency[$i]} > ./commandResult.txt 2>&1
    commandResult=$(<commandResult.txt)
    rm commandResult.txt
    if [[ "$commandResult" == *"$dpkgSCheck"* ]]; then
        if [[ $ignoreEcho = false ]]; then
            echo -e "${CYAN}[Dependency] : ${waylandDependency[$i]} checked.${NC}"
        fi
    else 
    if [[ $ignoreEcho = false ]]; then
        echo -e "${RED}[Error]${NC} : ${waylandDependency[$i]} is missing use the following command to install it :
sudo apt install ${waylandDependency[$i]}"
    fi
        $missingDependency= true
    fi
done
if [[ $missingDependency = true ]]; then 
    exit 1 
fi
if [[ $ignoreEcho = false ]]; then  
    echo -e "${GREEN}[GL] All dependencies are checked.${NC}👍️"
fi
exit 0