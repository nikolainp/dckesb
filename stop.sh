#!/bin/bash

docker exec -it esb \
    ./bin/esb stop --pidfile /var/opt/1C/1CE/instances/1c-enterprise-esb-with-ide/daemon.pid