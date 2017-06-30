import sys
import os

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

def write_to_file ( oldversion, newversion ):
	filename = os.path.join(os.pardir, 'git/pinano/README.md')
	file_object=open(filename,'r')
	filedata = file_object.read()
       	file_object.close()
	newfiledata = filedata.replace(oldversion, newversion)
	file_object=open(filename,'w')
	file_object.write( newfiledata );
       	file_object.close()


if len(sys.argv)<2:
        handleError ("missing argument containing nano arhive file name")

nano_folder = extract_folder_name ( sys.argv[1] )

new_nano_version = extract_version ( nano_folder )
nano_version_list = new_nano_version.split(".")
lastnumber = int(nano_version_list[len(nano_version_list)-1])
lastnumber = lastnumber - 1
nano_version_list[len(nano_version_list)-1] = str(lastnumber)
old_nano_version=".".join(str(x) for x in nano_version_list)

write_to_file ( old_nano_version, new_nano_version )
