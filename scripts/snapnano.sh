#!/bin/sh

: <<'LICENSE'
    Copyright (C) {2017}  {Bota Viorel}

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program. If not, see <http://www.gnu.org/licenses/>.
LICENSE

handle_error ()
{
        echo "ERROR: $@"
        exit 0
}

echo "TITLE: PACK NANO IN PINANO SNAP AND UPLOAD TO UBUNTU STORE. 5 STEPS"

echo "Copyright (C) {2017}  {Bota Viorel}
 This program comes with ABSOLUTELY NO WARRANTY.
 This is free software, and you are welcome to redistribute it under the GPL conditions. 
"

if [ -z "${1}" ]; then
        handle_error "missing nano archive name"
fi

cd ../snap

echo "Step 0 of 5: remove old pinano snaps and snaprcraft.yaml"
rm pinano_*
rm snapcraft.yaml

echo "Step 1 of 5: create snapcraft.yaml"
cd ../scripts
python createsnapcraft_yaml.py $1

if [ ! -f snapcraft.yaml ]; then
        handle_error "snapcraft.yaml was not created"
fi

cd ../snap

echo "Step 2 of 5: clean pull (needed to update source)"
snapcraft clean pinano -s pull

echo "Step 3 of 5: create snap"
snapcraft

NANO_FOLDER_NAME=${1%.t*} 
VERSION=${NANO_FOLDER_NAME#*-}
SNAP_NAME="pinano_"$VERSION"_armhf.snap"

if [ ! -f $SNAP_NAME ]; then
	handle_error "snap file $SNAP_NAME not created"
fi

echo "Step 4 of 5: push snap"
TMP="$(snapcraft push $SNAP_NAME 2>&1)"

echo "Step 5 of 5: release snap"
TMP=${TMP#*Revision }
REVISION=${TMP% of*} 
snapcraft release pinano $REVISION stable

echo "finished"
exit 1
