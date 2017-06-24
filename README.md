# pinano
This is the GNU nano text editor version 2.8.4 packed as a snap for raspberry PI. 

The source code used in this snap, is copied from the GNU nano svn, and stored in the following location: 

https://github.com/VBota1/pinano/tree/master/nano-2.8.4


All credits go to the GNU nano developers: 

 https://github.com/VBota1/pinano/nano-2.8.4/AUTHORS 
 
 https://www.nano-editor.org/who.php

# installation from github:
  1. First download the snap:
    * manual from https://github.com/VBota1/pinano/snap
    * or by cloning repository: ```git clone https://github.com/VBota1/pinano```
  2. Then navigate to the folder containing the snap
  3. Then run:
    ```sudo snap install --dangerous pinano_2.8.4_armhf.snap```

# installation from ubuntu store
  ```sudo snap install pinano```
  
# Write/Read rights
  To get Read and Write access to files stored in various location you need to manually connect the application to the appropriate sockets of the system.
  
  This is needed as these system sockets are not autoconnect.
  
  You only need to do this once after installation. 
  
  The implemented plugs can be connected with the following commands:
  
  ```sudo snap connect pinano:home core:home```
  
  ```sudo snap connect pinano:raw-usb core:raw-usb```
  
  ```sudo snap connect pinano:removable-media core:removable-media```

# Usage example
  ```pinano test```
