#!/bin/bash

mkdir /tmp//esb
chmod 777 /tmp/esb
docker run \
    -v /tmp/esb:/var/opt/1C/1CE/instances/1c-enterprise-esb-with-ide \
    -p 9090:9090 -p 8080:8080 -p 6698:6698 \
    --name esb \
    esb \
