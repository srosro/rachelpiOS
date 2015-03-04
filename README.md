Installation instructions
=====

Note: This has been tested on the following hardware:

* Raspberry Pi 2
* WiFi antenna: http://www.amazon.com/gp/product/B00H95C0A2/
* 64GB SD card: http://www.amazon.com/gp/product/B0081EAK34/


* Download a fresh version of NOOBS and install on a 64GB SD card: http://www.raspberrypi.org/help/noobs-setup/
* Connect to ethernet (wired) or wireless:

```
login: pi
password: raspberry
$ startx #once the GUI has loaded go to: Menu > Preferences > WiFi Configuration
```

* Continue on the command line:

```
$ git clone https://github.com/rachelproject/rachelpiOS.git
$ cd rachelpiOS # shift into new directory
$ sudo chmod -R 775 ./scripts # Change permissions to allow us to execute script
$ ./scripts/rachelpios.sh # Execute script (note, this will disconnect you from WIFI (if you're connected)
```

* Go through prompts (entering Y to the quesitons).
* Set mysql password: "rachellovespie"
* Test it out! From another machine, connect to "RPI" wireless network, and visit http://10.10.10.10/
* Install sphider tables by visiting http://10.10.10.10/rsphider/admin/install_tables.php
 * User: root
 * Password: rachellovespie
