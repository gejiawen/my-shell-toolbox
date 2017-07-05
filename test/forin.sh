arr=(1 2 3)


for ip in ${arr[@]:1:${#arr[@]}}; do
    echo
    echo $ip
    echo
done
