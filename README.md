Installation instructions
=====

Note: This has been tested on the following hardware:
- Raspberry Pi 2
- WiFi antenna: http://www.amazon.com/gp/product/B00H95C0A2/
- 64GB SD card: http://www.amazon.com/gp/product/B0081EAK34/

1. Download a fresh version of NOOBS and install on a 64GB SD card: http://www.raspberrypi.org/help/noobs-setup/
2. Connect to ethernet (wired) or wireless:

```
login: pi
password: raspberry
$ startx #once the GUI has loaded go to: Menu > Preferences > WiFi Configuration
```

3. Continue on the command line:

```
$ git clone https://github.com/rachelproject/rachelpiOS.git
$ cd rachelpiOS # shift into new directory
$ sudo chmod -R 775 ./scripts # Change permissions to allow us to execute script
$ ./scripts/rachelpios.sh # Execute script (note, this will disconnect you from WIFI (if you're connected)
```

4. Go through prompts (entering Y to the quesitons).
5. Set mysql password: "rachellovespie"
