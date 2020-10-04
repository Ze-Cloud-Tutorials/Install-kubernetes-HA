#!/bin/bash

#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.

#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.

#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <https://www.gnu.org/licenses/>.

# Install The Docker container run time

if [ -z $DOCKER_VERSION ]
then
  DOCKER_VERSION="5:19.03.13~3-0~ubuntu-"$(lsb_release -cs)
fi

if [ -z $CONTAINERD_VERSION ]
then
  CONTAINERD_VERSION="1.3.7-1"
fi


echo ""
echo "To retrieve the latest version of docker run the following command: 'sudo apt-get update && sudo apt-cache policy docker-ce'"
echo "To retrieve the latest version of container.d run the following command: 'sudo apt-get update && sudo apt-cache policy containerd.io'"

echo ""
echo "Installing Docker version '$DOCKER_VERSION' and Container.d version '$CONTAINERD_VERSION', do you wish to continue ?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) echo "Abrorting"; exit 1;;
    esac
done

### Install packages to allow apt to use a repository over HTTPS
sudo apt-get update && sudo apt-get install -y \
  apt-transport-https ca-certificates curl software-properties-common gnupg2

# Add Docker's official GPG key:
echo "Adding Docker's official GPG key"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add the Docker apt repository:
REPO="https://download.docker.com/linux/ubuntu"
if ! grep -q "$REPO" /etc/apt/sources.list; then
  echo "Adding '$REPO' repository"
  sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"
fi


# Install Docker CE
sudo apt-mark unhold containerd.io docker-ce docker-ce-cli
sudo apt-get update && sudo apt-get install -y \
  containerd.io=$CONTAINERD_VERSION \
  docker-ce=$DOCKER_VERSION \
  docker-ce-cli=$DOCKER_VERSION
sudo apt-mark hold containerd.io docker-ce docker-ce-cli

# Set up the Docker daemon
sudo su -c '
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
'

sudo mkdir -p /etc/systemd/system/docker.service.d

# Restart Docker
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl enable docker

echo "Docker is configured on $HOSTNAME"


exit 0