# dlpTestScript
Quick dirty script to generate fake PII for DLP testing

Developed for macOS, but could work on other *NIX operating systems that support `.zsh` by adjusting output destination  

By default, script creates 1,000 CSV files with 1,000 rows each.
Each row contains a fake "Customer ID," "SSN," and "CC" (credit card number)

To customize:

```sh   
-c number of files to create  
-r number of rows per file
-x alternate file extension to use instead of ".csv"
```

Example:
```sh
# This will create 100 \".rtf\" files, each with 700 rows of data
dlpTest.sh -c 100 -r 700 -x rtf
```

Useful for testing crappy DLP agents that your Cyber people want you to run on your Macs, because they don't understand modern DLP strategies.
