#!/usr/bin/env bash

set -e

source .env.workstation # Load the dependencies versions

opts=""

while true; do
    case "$1" in
    --no-cache)
        opts=" --no-cache "
        shift ;;
    '')
        break;;
    *)
        echo "Invalid argument $1";
        exit 1
  esac
done

DIR_NAME=`basename "${PWD}"`
WKS_NAME="workstation-wsc-${DIR_NAME}"

USER_FOLDER=/home/workstation
DOCKER_ENV_FILE=./.env.workstation

docker stop -t0 ${WKS_NAME} && docker rm ${WKS_NAME}

docker build ${opts} -t ${WKS_NAME} -f ./workstation/Dockerfile \
    --build-arg AWSCLI_VERSION=${AWSCLI_VERSION} \
    --build-arg ANSIBLE_VERSION=${ANSIBLE_VERSION} \
    --build-arg JINJA_VERSION=${JINJA_VERSION} \
    --build-arg NETADDR_VERSION=${NETADDR_VERSION} \
    --build-arg BOTO3_VERSION=${BOTO3_VERSION} \
    --build-arg TF_VERSION=${TF_VERSION} \
    --build-arg PACKER_VERSION=${PACKER_VERSION} \
    --build-arg MYPACKAGE_VERSION=${MYPACKAGE_VERSION} \
    ./workstation

docker run -td --name ${WKS_NAME} \
    -v ~/.aws:${USER_FOLDER}/.aws \
    -v ~/.ssh:${USER_FOLDER}/.ssh \
    -v $(pwd)/:${USER_FOLDER}/workdir \
     --env-file=${DOCKER_ENV_FILE} \
    ${WKS_NAME}

docker exec -it ${WKS_NAME} bash

