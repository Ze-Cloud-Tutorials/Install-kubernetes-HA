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


# Update machine:
echo "Would you like to update $HOSTNAME machine ?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) echo "Updating ..."; break;;
        No ) echo "Abort ..."; exit 1;;
    esac
done

sudo apt-get update
sudo apt-get dist-upgrade -y
sudo apt-get autoclean -y
sudo apt-get autoremove -y

# Reboot if a kernel update have been done
echo "Would you like to reboot the server now ?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) echo "Rebooting ..."; sudo reboot; break;;
        No ) echo "Please reboot this machine later if a kernel update have been applied"; exit 1;;
    esac
done


exit 0