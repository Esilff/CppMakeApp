#!/bin/bash

RED='\033[0;31m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'


#Check for GLFW
echo -e "${YELLOW}Checking for GLFW dependency${NC}"
pkg-config --libs glfw3 > ./glfwCheck.txt 2>&1
glfwCheck=$(<glfwCheck.txt)
rm glfwCheck.txt
if [[ $glfwCheck == "-lglfw" ]]; then
    echo -e "${CYAN}[Dependency] : GLFW checked.${NC}"
else 
    echo -e "${RED}[Error]${NC} : GLFW3 is missing use the following commands to install it :
sudo apt-get install libglfw3
sudo apt-get install libglfw3-dev"
    exit 1
fi
#Check for Xorg presence
echo -e "${YELLOW}Checking for Xorg dependency${NC}"
dpkg -s xorg > ./xorgState.txt 2>&1
xorgState=$(<xorgState.txt)
rm xorgState.txt
dpkgSCheck='Status: install ok installed'
if [[ "$xorgState" == *"$dpkgSCheck"* ]]; then
    echo -e "${CYAN}[Dependency] : Xorg checked.${NC}"
else 
    echo -e "${RED}[Error]${NC} : Xorg is missing use the following command to install it :
sudo apt install xorg-dev"
    exit 1
fi
#Check for wayland dependency
echo -e "${YELLOW}Checking for Wayland dependencies.${NC}"
waylandDependency=('libwayland-dev' 'libxkbcommon-dev' 'wayland-protocols' 'extra-cmake-modules')
missingDependency= false
for i in ${!waylandDependency[@]}; do
    dpkg -s ${waylandDependency[$i]} > ./commandResult.txt 2>&1
    commandResult=$(<commandResult.txt)
    rm commandResult.txt
    if [[ "$commandResult" == *"$dpkgSCheck"* ]]; then
        echo -e "${CYAN}[Dependency] : ${waylandDependency[$i]} checked.${NC}"
    else echo -e "${RED}[Error]${NC} : ${waylandDependency[$i]} is missing use the following command to install it :
sudo apt install ${waylandDependency[$i]}"
        $missingDependency= true
    fi
done
if [[ $missingDependency = true ]]; then 
    exit 1 
fi  
echo -e "${GREEN}[GL] All dependencies are checked.${NC}👍️"