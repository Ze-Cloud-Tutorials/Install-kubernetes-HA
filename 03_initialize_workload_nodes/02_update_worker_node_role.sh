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

# Add a role to a node:

if [ -z $ROLE ]
then
  echo "Please entrer the role name:"
  read ROLE
fi

if [ -z $NODE ]
then
  echo "Please enter the node name:"
  read NODE
fi
echo "Would you like to set the role '$ROLE' for node '$NODE' ?"

select yn in "Yes" "No"; do
    case $yn in
        Yes ) kubectl label nodes $NODE node-role.kubernetes.io/$ROLE=""; break;;
        No ) echo "Aborting ..."; exit 1;;
    esac
done


exit 0
