docker-compose down --remove-orphans;
# docker rmi $(docker images -q);
docker system prune -f;
docker-compose up -d;