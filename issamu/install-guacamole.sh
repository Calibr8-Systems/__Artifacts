#!/bin/bash
echo "[$(date)] Starting Guacamole installation"

read -p "Get Portainer? (y/n): " portainer_install
if [ "$portainer_install" = "y" ]; then
        docker volume create portainer_data
        docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:lts
elif [ "$portainer_install" = "n" ];then
        echo "No Portainer. Got it!"
else
        echo "Wrong input!"
fi

mkdir /guacamole
cd /guacamole || exit 1

# get compose file
curl --no-progress-meter https://raw.githubusercontent.com/Calibr8-Systems/__Artifacts/refs/heads/master/issamu/guacamole-compose.yaml >> docker-compose.yaml

# get .env file
curl --no-progress-meter https://raw.githubusercontent.com/Calibr8-Systems/__Artifacts/refs/heads/master/issamu/default-guacamole.env >> .env

# docker must be intalled on the systems you are trying to use this script on!
docker compose up -d

echo "[$(date)] Guacamole installation completed"