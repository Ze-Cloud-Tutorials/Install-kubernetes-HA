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


# Retrieve current host name
CURRENT_HOST_NAME=$HOSTNAME

if [ -z $NEW_HOST_NAME ]
then
  echo "Please enter you new host name"
  read NEW_HOST_NAME
fi

echo "Would you like to change the host name from '$CURRENT_HOST_NAME' to '$NEW_HOST_NAME' ?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) sudo hostnamectl set-hostname $NEW_HOST_NAME;
              sudo sed -i "s/$CURRENT_HOST_NAME/$NEW_HOST_NAME/g" /etc/hosts; break;;
        No ) echo "Abort ... "; exit 1;;
    esac
done

# Reboot server so changes take effect
echo "Would you like to reboot the server now ?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) echo "Rebooting ..."; sudo reboot; break;;
        No ) echo "Please reboot this machine later for the host name to be configured"; exit 1;;
    esac
done


exit 0