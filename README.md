
Save your Android data using internal wifi network
==================================================

Install
-------

### On your box configuration page

Go on your box web configuration page.

For SFR box go on https://192.168.1.1/
Sometimes, authentication can be done directly with a 5s press on a box button.

Then freeze the Android local IP address, in the DHCP configuration (something like 192.168.1.XX).



### On mobile phone
Add an FTP server.

One can use [FTP Server (Free)](https://f-droid.org/en/packages/be.ppareit.swiftp_free/).


### On the computer
- Install `curlftpfs`

	sudo apt install curlftpfs

- Configure the script [synch_phone.sh](./synch_phone.sh) (doc is embedded on the first lines).


Synchronize
-----------

At home, connect your mobile and computer to the wifi.
Start the mobile FPT server.
Launch the script :

	./synch_phone.sh

