FROM mcr.microsoft.com/dotnet/sdk:5.0-alpine as builder

ARG LMP_VERSION=0.28.0
ARG LMP_FILENAME=LunaMultiplayer-Server-Release.zip
ARG LMP_URL=https://github.com/LunaMultiplayer/LunaMultiplayer/releases/download/$LMP_VERSION/$LMP_FILENAME

RUN wget $LMP_URL
RUN unzip $LMP_FILENAME
RUN rm -rf $LMP_FILENAME LMPClient LMP\ Readme.txt

WORKDIR LMPServer

EXPOSE 8800/udp
EXPOSE 8900/tcp

VOLUME ["Universe", "Config", "Plugins"]

CMD ["dotnet", "Server.dll"]
