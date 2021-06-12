#!/bin/bash

IMAGE_NAME=postfix-dovecot
CONTAINER_NAME=mypostfix

docker build -t $IMAGE_NAME .

docker run \
    --privileged \
    --name $CONTAINER_NAME \
    -p 25:25 \
    -p 110:110 \
    -td $IMAGE_NAME \
    /sbin/init
