

while (( addGlDep != 'y'|'n' )); 
do
    read -sp '[y/n] : ' addGlDep
done  
echo $addGlDep
exit 0