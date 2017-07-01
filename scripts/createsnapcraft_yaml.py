#    Copyright (C) {2017}  {Bota Viorel}
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program. If not, see <http://www.gnu.org/licenses/>.

import sys

def handleError ( str ):
	print "ERROR: ",str
	sys.exit(0)

def extract_folder_name ( str ):
	tmp = str.split(".t")

	if len(tmp)<2:
		handleError("could not extract nano folder name from argument")

	return tmp[0]

def extract_version ( str ):
	tmp = str.split("-")

	if len(tmp)<2:
		handleError("could not extract nano version number from argument")

	return tmp[1]

def write_to_file ( folder_name, version ):
	file_object  =  open("../snap/snapcraft.yaml","w+")

	file_object.write("name: pinano\n")

	version_text = "version: \'" + nano_version + "\'\n"
	file_object.write(str(version_text))

	file_object.write("summary: GNU nano text editor\n")
	file_object.write("description: |\n")

	description_text = "  This is the GNU nano text editor version " + nano_version + " packed as a snap for raspberry PI. The source code for this snap can be found at https://github.com/VBota1/pinano. All credits go to the GNU nano developers https://www.nano-editor.org/who.php To get writing access connect to the follwoing plugs: sudo snap connect pinano:home core:home | sudo snap connect pinano:raw-usb core:raw-usb | sudo snap connect pinano:removable-media core:removable-media\n"
	file_object.write(str(description_text))

	file_object.write("\n")
	file_object.write("grade: stable\n")
	file_object.write("confinement: strict\n")
	file_object.write("\n")
	file_object.write("parts:\n")
	file_object.write("  pinano:\n")

	source_text = "    source: /home/vbota/workspace/nano/" + nano_folder + "\n"
	file_object.write(str(source_text))

	file_object.write("    plugin: autotools\n")
	file_object.write("\n")
	file_object.write("apps:\n")
	file_object.write("  pinano:\n")
	file_object.write("    command: bin/nano\n")
	file_object.write("    plugs: [home, raw-usb, removable-media]")

	file_object.close()



if len(sys.argv)<2:
	handleError ("missing argument containing nano arhive file name")

nano_folder = extract_folder_name ( sys.argv[1] )

nano_version = extract_version ( nano_folder )

write_to_file ( nano_folder, nano_version )
