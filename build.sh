#!/bin/bash

./stop.sh &2>/dev/null

[ -z "$( uname -a | grep -io pi )" ] && {
    DOCKERFILE=Dockerfile
} || {
    DOCKERFILE=Dockerfile_Pi
}

sudo docker build --file "$DOCKERFILE" -t lmpsrv:latest .
sudo docker container rm lmpsrv &2>/dev/null
sudo docker create \
  --name=lmpsrv\
  -e TZ=PST \
  -p 8800:8800/udp  \
  -p 8900:8900  \
  -v $( pwd )/LunaMultiplayer/Config:/LMPServer/Config  \
  -v $( pwd )/LunaMultiplayer/Universe:/LMPServer/Universe  \
  -v $( pwd )/LunaMultiplayer/Plugins:/LMPServer/Plugins  \
  -v $( pwd )/LunaMultiplayer/logs:/LMPServer/logs  \
  -v $( pwd )/LunaMultiplayer/Server:/LMPServer/Server  \
  --restart unless-stopped lmpsrv

mkdir -p $( pwd )/LunaMultiplayer/{Config,Universe,Plugins,logs,Server}/
chmod g+s $( pwd )/LunaMultiplayer/*/
chmod o+s $( pwd )/LunaMultiplayer/*/

cp ./config/* ./LunaMultiplayer/Config/
