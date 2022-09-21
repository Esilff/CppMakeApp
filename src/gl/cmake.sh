#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

$(./checkGlDependency.sh -i)

cmakeConfig=''

if [[ $? -eq 0 ]]; then
   cmakeConfig=$(<./conf/cmake.txt)
else 
    echo -e "${RED}[Error] : Some dependencies are missing, use <command> to check the missing ones.${NC}"
    exit 1
fi

printf $cmakeConfig > CMakeLists.txt