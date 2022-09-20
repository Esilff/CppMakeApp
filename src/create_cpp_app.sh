#!/bin/bash

#version 0.1
# this script create a cmake cpp application for linux, it takes the following info in order to make the project
# project-name, project-path

#-------------------------------------------------------------------------------------------------------------------------

# ---------------------------- vars ----------------------------

# --- colors ---

CYAN='\033[0;36m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color


# ---------------------------- start ----------------------------------

#asking for project path and project name

echo -e "${CYAN}Starting process in order to create a C++ Application, please provide the required information :\n${NC}"
read -p 'Project-name: ' pjnamevar #ask for the project name
read -p 'Project-path: ' pjpathvar #ask for the project path
path="${pjpathvar}/${pjnamevar}" # concat the project path and project name resulting in $projectPath/$projectName
mkdir -p "$path"
cd $path
mkdir src
cd src

#making the main.cpp file

printf "#include <iostream>

    int main(void) {
        std::cout << \"Hello, world !\" << std::endl;
        return 0;
    }" > main.cpp

#making a basic Cmake file

printf "cmake_minimum_required(VERSION 3.12)

project(${pjnamevar})

add_executable(\${PROJECT_NAME} main.cpp)" > CMakeLists.txt

cd ..
mkdir build
mkdir scripts
cd scripts

#adding a run script in order to build, compile and run the project

printf "echo -e \"${CYAN}Building project :${NC}\"
cmake -S ./src -B ./build
cd ./build
make
echo  -e \"${YELLOW}Running project ${NC}\":
./${pjnamevar}
" > run.sh
chmod +x ./run.sh

cmake -S ../src -B ../build
