#!/bin/sh

handle_error ()
{
        echo "ERROR: $@"
        exit 0
}

echo "TITLE: UPLOAD CODE AND BINARY TO GITHUB. 5 STEPS"

if [ -z "${1}" ]; then
        handle_error "missing nano archive name"
fi

cd ../git/pinano

echo "Step 0 of 5: sync to master"
git fetch
git reset --hard origin/master

echo "Step 1 of 5: s checkout & pull master"
git checkout master
git pull origin master

echo "Step 2 of 5: remove old sources"
NANO_FOLDER_NAME=${1%.t*} 
VERSION=${NANO_FOLDER_NAME#*-}
SNAP_NAME="pinano_"$VERSION"_armhf.snap"

git rm -r nano*
git rm snap/pinano*
git rm snap/snapcraft.yaml
git commit -m "removed old sources"
git push

echo "Step 3 of 5: update README"
cd ../../scripts
python updategitreadme.py $1
cd ../git/pinano
git add README.md

echo "Step 4 of 5: copy new sources"
cd ../..
cp -R $NANO_FOLDER_NAME git/pinano/
cp snap/$SNAP_NAME git/pinano/snap/
cp snap/snapcraft.yaml git/pinano/snap/
cd git/pinano

echo "Step 5 of 5: upload new sources"
git add $NANO_FOLDER_NAME
cd snap
git add $SNAP_NAME
git add $snapcraft.yaml
cd ..
git commit -m "update to $NANO_FOLDER"
git push

