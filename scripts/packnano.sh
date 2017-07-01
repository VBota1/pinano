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
        exit 0
}

echo "Copyright (C) {2017}  {Bota Viorel}
 This program comes with ABSOLUTELY NO WARRANTY.
 This is free software, and you are welcome to redistribute it under the GPL conditions. 
"

./getnanosource.sh $1
if [ $? -eq 0 ]; then
	handle_error
fi

./snapnano.sh $1
if [ $? -eq 0 ]; then
	handle_error
fi

./updategit.sh $1
