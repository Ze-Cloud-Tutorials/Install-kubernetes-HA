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



# Installing Kubernetes tools: Kubeadm, Kubelet, Kubectl
if [ -z $KUBERNETES_VERSION ]
then
  KUBERNETES_VERSION="1.18.9-00"
fi

echo ""
echo "To retrieve the latest version of kubeadm run the following command: 'apt-get update && apt-cache policy kubeadm'"

echo ""
echo "Installing Kubernetes tools version '$KUBERNETES_VERSION', do you want to continue ?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) echo "Abrorting"; exit 1;;
    esac
done
# Add kubernetes Key
echo "Adding Google Cloud's official GPG key"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# Add the Kubernetes apt repository:
REPO="https://apt.kubernetes.io/"

echo "Adding '$REPO' repository"
sudo cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

# Installing Kubelet, Kubeadm and Kubectl packages
sudo apt-mark unhold kubelet kubeadm
sudo apt-get update
sudo apt-get install -y kubelet=$KUBERNETES_VERSION kubeadm=$KUBERNETES_VERSION kubectl --allow-downgrades
sudo apt-mark hold kubelet kubeadm


# Optional, pull config images
echo "Would you like to pull kubeadm config images now ?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) sudo kubeadm config images pull;break;;
        No ) echo "Skipping"; exit 0;;
    esac
done


exit 0