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


# Check if a load balancer ip have beenprovided
if [ -z $LOAD_BALANCER_IP ]
then
  echo "Please enter the IP address of the load balancer:"
  read LOAD_BALANCER_IP
fi

# Check if a kubernetes version have been provided
if [ -z $K8S_VERSION ]
then
  echo "Please enter the Kubernetes version to install, leave empty to use version '1.18.9'"
  read K8S_VERSION
fi

# Launch the kubeadm init command
if [ -z $K8S_VERSION ]
then
  K8S_VERSION="1.18.9"
fi

sudo kubeadm init --control-plane-endpoint "$LOAD_BALANCER_IP:6443" \
      --kubernetes-version $K8S_VERSION \
      --apiserver-advertise-address "$LOAD_BALANCER_IP" \
      --upload-certs


exit 0