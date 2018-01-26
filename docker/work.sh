#!/usr/bin/env bash

# ------------------------------------
# @description
#   镜像工作维护脚本
#
# @usage
#   ./work.sh [action]
#
# @params
#   action - action表示工作脚本任务，目前有 ‘build’， ‘push’， ‘run’，‘clean’
#
# @author
#   gejiawen<806717031@qq.com>
# ------------------------------------

docker_registry="<YOUR_DOCKER_REGISTRY>"
docker_registry_path="YOUR_DOCKER_REGISTRY_PATH"
docker_image_name="<YOUR_DOCKER_IMAGE_NAME>"
docker_image_version="<YOUR_DOCKER_IMAGE_VERSION>"
docker_image_path="${docker_registry}/${docker_registry_path}/${docker_image_name}"
docker_container_name="<YOUR_CONTAINER_NAME>"
docker_username="<YOUR_USERNAME>"
docker_pwd="<YOUR_PASSWORD>"

function echo_and_exe () {
    echo
    echo "cmd: $*"
    eval $*
    ret=$?

    return $ret
}

function build () {
    echo "------------------------------------"
    echo "docker image name: ${docker_image_name}:${docker_image_version}"
    echo "docker image path: ${docker_image_path}:${docker_image_version}"

    cmd="docker build -t ${docker_image_path}:${docker_image_version} ."
    echo_and_exe $cmd

    if [[ $? -ne 0 ]]; then
        echo "error at: ${cmd}"
        exit 1
    else
        echo "build ${docker_image_path}:${docker_image_version} success!"
        echo "------------------------------------"
    fi

    exit 0
}

function demo () {
    echo "------------------------------------"
    count=`docker ps -a | grep ${docker_container_name} | wc -l`
    if [[ ${count} -lt 1 ]];then
        docker run -itd --name ${docker_container_name} ${docker_image_path}:${docker_image_version}
    else
        docker rm -fv ${docker_container_name}
        docker run -itd --name ${docker_container_name} ${docker_image_path}:${docker_image_version}
    fi
    echo "------------------------------------"

    exit 0
}

function push () {
    echo "------------------------------------"
    echo "login ${docker_registry}"
    docker login --username=${docker_username} ${docker_registry} --password=${docker_pwd}
    docker push ${docker_image_path}:${docker_image_version}
    echo "------------------------------------"

    exit 0
}

function run () {
    echo "------------------------------------"
    # your business logic
    echo "------------------------------------"
    exit 0
}

function clean () {
    echo "------------------------------------"
    echo "will remove docker container: ${docker_container_name}"
    echo "will remove docker image: ${docker_image_path}:${docker_image_version}"
    echo "------------------------------------"
    docker rm -fv ${docker_container_name}
    docker rmi ${docker_image_path}:${docker_image_version}
    echo "------------------------------------"

    exit 0
}

action=$1

if [[ -z $action ]];then
    echo "[ERROR] action is missing."
    exit 1
elif [[ $action == "build" ]];then
    build
elif [[ $action == "demo" ]];then
    demo
elif [[ $action == "push" ]];then
    push
elif [[ $action == "run" ]];then
    run
elif [[ $action == "clean" ]];then
    clean
else
    echo "[ERROR] unsupported action type."
    exit 1
fi
