while [ true ]
do
    str=`date +%Y%m%d-%H-%M-%S-%s`
    str2=`curl -I -m 10 -o /dev/null -s -w %{http_code} "http://localhost:3000"`
    echo ${str}, ${str2}
done
