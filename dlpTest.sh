#!/bin/zsh
# shellcheck shell=bash
# Version 2.0

# Default Values
fileCount=100
rowCount=1000
fileX="csv"

outputDir=$(mktemp -d ${HOME}/Desktop/Customers.XXXX)

generateFakeDLP ()
{
  outputFile=$(mktemp "${outputDir}"/customerInfo.XXXX) || exit 1
  echo "Customer ID,SSN,CC" >> "${outputFile}"
  count=0
  until (( $count == $rowCount ))
  do
    echo "${(l:9::0:)${RANDOM}},${(l:3::0:)${RANDOM}}-${(l:2::0:)${RANDOM}}-${(l:4::0:)${RANDOM}},${(l:4::0:)${RANDOM}}-${(l:4::0:)${RANDOM}}-${(l:4::0:)${RANDOM}}-${(l:4::0:)${RANDOM}}" >> "${outputFile}"
    count=$(( $count + 1 ))
  done
  mv "${outputFile}" "${outputFile}.$fileX"
}

# Default functions
fileCountStatement() { printf "\\n%b" "Creating ${BRED}$fileCount ${NC}files (${RED}DEFAULT${NC})" ;}
rowCountStatement() { printf "\\n%b" "Each file will contain ${BRED}$rowCount ${NC}rows (${RED}DEFAULT${NC})" ;}
fileXStatement() { printf "\\n%b" "Each file will use a ${BRED}$fileX ${NC}file extension (${RED}DEFAULT${NC})" ;}


while getopts ":c:x:r:h" opt; do
    case $opt in
        c)
            fileCount=$OPTARG
            if ! [[ $fileCount =~ ^[0-9]+$ ]]
              then echo "File count must be an integer" >&2; exit 1
            elif [[ $fileCount -lt 1 ]]
              then echo "File count must be greater than 0" >&2; exit 1
            fi
            fileCountStatement() { printf "\\n%b" "Creating ${BGREEN}$fileCount ${NC}files (${GREEN}CUSTOM${NC})" ;}
            ;;
        r)
            rowCount=$OPTARG
            if ! [[ $rowCount =~ ^[0-9]+$ ]]
              then echo "Row count must be an integer" >&2; exit 1
            elif [[ $rowCount -lt 1 ]]
              then echo "Row count must be greater than 0" >&2; exit 1
            fi
            rowCountStatement() { printf "\\n%b" "Each file will contain ${BGREEN}$rowCount ${NC}rows (${GREEN}CUSTOM${NC})" ;}
            ;;
        x)
            echo "-x was triggered, Parameter: $OPTARG"
            fileX=$OPTARG
            fileXStatement() { printf "\\n%b" "Each file will use a ${BGREEN}$fileX ${NC}file extension (${GREEN}CUSTOM${NC})" ;}
            ;;
        h)
            echo -e "\nusage dlpTest.sh -c <number of files to create per extension type> -r <number of rows per file> -x <alternate file extension to use instead of \".csv\">"
            echo -e "e.g. dlpTest.sh -c 100 -r 1000 -x rtf (will create 100 \".rtf\" files, each with 1000 rows of data)\n"
            exit 0
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument."
            exit 1
            ;;
    esac
done


#just a bit o color
RED='\033[0;31m'
BRED='\033[1;31m'
GREEN='\033[0;32m'
BGREEN='\033[1;32m'
NC='\033[0m' # No Color

printf "\\n%b" "--------------------------------------------------"
echo -e "\nPreparing to generate fake DLP files..\n"
fileCountStatement
rowCountStatement
fileXStatement
printf "\\n%b" "--------------------------------------------------${NC}\n\n"
sleep 5

loopCount=0
until (( $loopCount == $fileCount ))
do
  loopCount=$(( $loopCount + 1 ))
  echo "Creating test file ($loopCount out of $fileCount )"
  generateFakeDLP
done
