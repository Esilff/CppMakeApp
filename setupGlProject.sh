$(./checkGlDependency.sh -e)

if [[ $? -eq 0 ]]; then
    echo "Dependencies are checked"
else 
    echo "Some dependencies are missing"
fi