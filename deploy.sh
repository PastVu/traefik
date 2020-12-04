#/bin/bash
set -exu

source ~/env/traefik.env

docker network create --driver=overlay traefik-public || true
export NODE_ID=$(docker info -f '{{.Swarm.NodeID}}')
docker node update --label-add traefik-public.traefik-public-certificates=true $NODE_ID

export DOMAIN
export EMAIL
export USERNAME
export HASHED_PASSWORD=$(openssl passwd -apr1 $PASSWORD)

docker stack deploy -c traefik.yml traefik
