#/bin/bash
set -ex

docker network create --driver=overlay traefik-public || true
export NODE_ID=$(docker info -f '{{.Swarm.NodeID}}')
docker node update --label-add traefik-public.traefik-public-certificates=true $NODE_ID

echo DOMAIN
read DOMAIN
export DOMAIN

echo ADMIN EMAIL:
read EMAIL
export EMAIL

echo USERNAME:
read USERNAME
export USERNAME

echo PASSWORD:
read PASSWORD
export HASHED_PASSWORD=$(openssl passwd -apr1 $PASSWORD)

docker stack deploy -c traefik.yml traefik
