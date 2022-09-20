$(./checkGlDependency.sh -e)

if [[ $? -eq 0 ]]; then
    echo "Dependencies are checked"
else 
    echo "Some dependencies are missing"
fi

updateProject() {
    #the goal is to get an existing CMake file and to append the necessary content at the right place  
}