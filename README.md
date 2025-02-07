# What it is
A script for updating dynamic DNS (dyndns) records at Directnic. If you are a user of a domain with dynamic records at Directnic, then this script may be for you.

# This was forked from thoughtbox/ddns:main and simplified for my specific use case!

## Make the secret file
Place your secret (the 64 byte hex value between gateway/ and /?data in Directnic's provided unique URL) in the script's .rc file (_$HOME/.ddrc_), e.g.:
```
$ nano ~/.ddrc
```
Add a line for the hex value, ex:
```
KEY=ad133743f001e318e455fdc04
```
Ctrl^O to save, Ctrl^X to exit


## Make the shell script
### Check if you have a bin folder in your home directory
```
ls $HOME
```
If there is no bin listed in blue then 
```
mkdir $HOME/bin/
```

### Create the script
```
nano $HOME/bin/directnicddnsu.sh
```
copy text from github and paste

Ctrl^O to save, Ctrl^X to exit

Set the sh script to executable
```
chmod +x $HOME/bin/directnicddnsu.sh
```


## Add it to crontab; e.g. the following will run the script and update your DNS record every 60 minutes:
```
$ crontab -e
```
Add line to file
```
0 * * * * $HOME/bin/directnicddnsu.sh
```

You can read more about Directnic's dynamic DNS service here: https://directnic.com/knowledge#/knowledge/article/3726.
--Ensure that the file mode on .ddrc is correct (0400 or 0600); the script will complain if it is not. Once the above has been completed, run the script.



# dependencies
On OpenBSD there are no dependencies (assuming a recent version of OpenBSD), while Linux needs _curl_ installed.

# compatibility
It has been tested on Raspbian GNU/Linux 12 (bookworm)
