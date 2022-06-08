# dlpTestScript
Quick dirty script to generate fake PII for DLP testing

Tested only on macOS Catalina and up (including Big Sur Dev Beta)

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





echo -e "\nusage dlpTest.sh -c <number of files to create per extensio> -r <number of rows per file> -x <alternate file extension to use instead of \".csv\">"
echo -e "e.g. dlpTest.sh -c 100 -r 1000 -x rtf (will create 100 \".rtf\" files, each with 1000 rows of data)\n"
