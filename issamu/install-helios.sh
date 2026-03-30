#!/bin/bash
echo "[$(date)] Starting Helios installation"

read -p "Get Portainer? (y/n): " portainer_install
if [ "$portainer_install" = "y" ]; then
        docker volume create portainer_data
        docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:lts
elif [ "$portainer_install" = "n" ];then
        echo "No Portainer. Got it!"
else
        echo "Wrong input!"
fi

mkdir /helios
cd /helios || exit 1

# get compose file
curl --no-progress-meter https://raw.githubusercontent.com/Calibr8-Systems/__Artifacts/refs/heads/master/issamu/helios-compose.yaml >> docker-compose.yml

# get .env file
curl --no-progress-meter https://raw.githubusercontent.com/Calibr8-Systems/__Artifacts/refs/heads/master/issamu/default-helios.env >> .env
#echo -n "Enter access-token for .env file: "
#read token
#curl -O -H "Authorization: Token $token" http://10.10.10.33:6157/curator/39d29a7588204843831f78ea0b11ec91/raw/HEAD/default-helios.env

docker compose up -d

echo "[$(date)] Helios installation completed"