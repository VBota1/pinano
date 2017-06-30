#!/bin/sh

handle_error ()
{
        exit 0
}

./getnanosource.sh $1
if [ $? -eq 0 ]; then
	handle_error
fi

./snapnano.sh $1
if [ $? -eq 0 ]; then
	handle_error
fi

./updategit.sh $1
