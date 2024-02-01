# what it is
A script for updating dynamic DNS (dyndns) records at Directnic. If you are a user of a domain with dynamic records at Directnic, then this script may be for you.

# usage
Place your secret (the 64 byte hex value between gateway/ and /?data in Directnic's provided unique URL) in the script's .rc file (_$HOME/.ddrc_), e.g.:
```
$ cat ~/.ddrc
KEY=6f751f5d0b866de67c18ce310ecc2ef5d64b18152b797c392c2cf6c984f9c564
```

Ensure that the file mode on .ddrc is correct (0400 or 0600); the script will complain if it is not. Once the above has been completed, run the script.

You should probably add it to your crontab; e.g. the following will run the script and update your DNS record every 30 minutes:
```
$ crontab -l
*/30 * * * * $HOME/bin/dyndns.sh
```

You can read more about Directnic's dynamic DNS service here: https://directnic.com/knowledge#/knowledge/article/3726.

# dependencies
On OpenBSD there are no dependencies (assuming a recent version of OpenBSD), while Linux needs _curl_ installed.

# compatibility
It has been written and tested for OpenBSD and Linux.
