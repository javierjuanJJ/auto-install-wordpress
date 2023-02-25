apt-get update
apt-get upgrade -y
apt-get install openssh-server git net-tools make -y
apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y
mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
apt-get install docker-compose -y
docker pull hello-world:latest
docker pull wordpress:5.9-php7.4-fpm-alpine
docker pull wordpress:latest
docker pull stilliard/pure-ftpd:latest
docker pull mysql:5.7
docker pull phpmyadmin/phpmyadmin
docker pull nginx:1.14-alpine
docker pull michaelperrin/wordpress-toolbox:latest
docker run hello-world
