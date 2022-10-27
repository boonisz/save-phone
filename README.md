
Save your Android data using internal wifi network
==================================================

Install
-------

### Freeze your local phone IP on your internet box
**Note:** This step is not mandatory. You can skip it but then your IP will change at each connection.
Those, you will have to update script each time with the proper IP.


Go on your box web configuration page.

For SFR box go on [https://192.168.1.1/](https://192.168.1.1/)
Sometimes, authentication can be done directly with a 5s press on a box button.

Then freeze the Android local IP address, in the DHCP configuration (something like 192.168.1.XX).



### On mobile phone
Add an FTP server.

One can use [FTP Server (Free)](https://f-droid.org/en/packages/be.ppareit.swiftp_free/).
This app has a widget that show IP address when turned on.


### On the computer
- Install `lftp`

	sudo apt install lftp

- Configure the script [phone_synch.sh](./phone_synch.sh) (doc is embedded on the first lines).


Synchronize
-----------
At home, connect your mobile and computer to the wifi.
Start the mobile FPT server, using the widget
Launch the script :

	./synch_phone.sh


Have also a memory card on your phone?
--------------------------------------
No problemo :)
Configure also the script [card_synch.sh](./card_synch.sh) and to launch both synchronisation, run:

	./run.sh

