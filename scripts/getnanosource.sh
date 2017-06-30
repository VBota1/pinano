#!/bin/sh

handle_error ()
{
        echo "ERROR: $@"
        exit 0
}

echo "TITLE: GET NANO SOURCE CODE 2 STEPS"

if [ -z "${1}" ]; then
        handle_error "missing nano archive name"
fi

cd ..

echo "Step 0 of 2: remove old nano folder and archive"
rm -r nano-*

echo "Step 1 of 2 : get nano source archive $1"
curl -O https://www.nano-editor.org/dist/v2.8/$1

if [ ! -f $1 ]; then
        handle_error "nano archive was not downloaded"
fi

echo "Step 2 of 2: unpack $1"
tar -xf $1

NANO_FOLDER_NAME=${1%.t*} 
if [ ! -d $NANO_FOLDER_NAME ]; then
        handle_error "nano folder was not unpacked"
fi

echo "finished"
exit 1
