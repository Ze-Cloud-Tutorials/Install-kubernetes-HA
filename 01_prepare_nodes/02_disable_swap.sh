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

# Disable swap
# Get the swap files name:
SWAP_FILES_PATH=$(swapon --show | sed 1d | awk '{print $1}')

echo "Swap files found: " $(wc -w <<< $SWAP_FILES_PATH)

# Disable Swap file
for SWAP_FILE in $SWAP_FILES_PATH
do
    echo "Do you wish to delete the swap file : " $SWAP_FILE
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) echo "removing $SWAP_FILE"; sudo swapoff -v $SWAP_FILE; \
                    sudo rm $SWAP_FILE; sudo sed -i "/\\$SWAP_FILE/d" /etc/fstab ; break;;
            No ) echo "Swap file '$SWAP_FILE' is still enabled"; exit 1;;
        esac
    done
done

echo "SWAP is disabled on " $HOSTNAME


exit 0