#!/bin/bash

./stop.sh

sudo docker build -t lmpsrv:latest .
sudo docker container rm lmpsrv
sudo docker create \
  --name=lmpsrv\
  -e TZ=CET \
  -p 8800:8800/udp  \
  -p 8900:8900  \
  -v $( pwd )/LunaMultiplayer/Config:/LMPServer/Config  \
  -v $( pwd )/LunaMultiplayer/Universe:/LMPServer/Universe  \
  -v $( pwd )/LunaMultiplayer/Plugins:/LMPServer/Plugins  \
  -v $( pwd )/LunaMultiplayer/logs:/LMPServer/logs  \
  -v $( pwd )/LunaMultiplayer/Server:/LMPServer/Server  \
  --restart unless-stopped lmpsrv
