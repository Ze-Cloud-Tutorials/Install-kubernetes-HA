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

echo "Would you like to create a new master join command (Token + Certificate) ?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) JOIN_COMMAND=$(sudo kubeadm token create --print-join-command 2> /dev/null | tail - -n 1 );
              CERTIFICATE_KEY=$(sudo kubeadm init phase upload-certs --upload-certs 2> /dev/null | tail - -n 1);
              echo "Master node join command :";
              echo "$JOIN_COMMAND --control-plane --certificate-key $CERTIFICATE_KEY"; break;;
        No ) echo "Aborting ..."; exit 1;;
    esac
done


exit 0