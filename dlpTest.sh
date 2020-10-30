#!/bin/zsh
# shellcheck shell=bash

outputDir=$(mktemp -d ${HOME}/Desktop/Customers.XXXX)

generateFakeDLP ()
{
  outputFile=$(mktemp "${outputDir}"/customerInfo.XXXX) || exit 1
  echo "Customer ID,SSN,VISA" >> "${outputFile}"
  count=0
  until (( $count > 1000 ))
  do
    echo "${(l:9::0:)${RANDOM}},${(l:3::0:)${RANDOM}}-${(l:2::0:)${RANDOM}}-${(l:4::0:)${RANDOM}},${(l:4::0:)${RANDOM}}-${(l:4::0:)${RANDOM}}-${(l:4::0:)${RANDOM}}-${(l:4::0:)${RANDOM}}" >> "${outputFile}"
    count=$(( $count + 1 ))
  done
  mv "${outputFile}" "${outputFile}.csv"
}

loopCount=0
loopLimit=1000
until (( $loopCount > $loopLimit ))
do
  loopCount=$(( $loopCount + 1 ))
  echo "Creating test file ($loopCount out of $loopLimit )"
  generateFakeDLP
done
