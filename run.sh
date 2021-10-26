#!/bin/bash

IMAGE_NAME=postfix-dovecot
CONTAINER_NAME=mypostfix

if [ "$(docker container ls -q -a -f name="$CONTAINER_NAME")" ]; then
    echo "Image ${NAME_IMAGE} already exist."
    docker start $CONTAINER_NAME
    exit
fi

docker build -t $IMAGE_NAME .

docker run \
    --privileged \
    --name $CONTAINER_NAME \
    -p 25:25 \
    -p 110:110 \
    -td $IMAGE_NAME \
    /sbin/init
