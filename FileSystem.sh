#!/bin/bash

# Student 1  : Ali Mohammadian - 201807939 - Section B02
# Student 2  : Mohamed Daniel Bin Mohamed Izham - 201802738 - Section B01
# Course     : CMPS 405 - Operating Systems
# Assignment : Project 1
# Instructor : Heba D. M. Dawoud

# for testing purposes

cat /dev/null > OUTFILE.txt
cat /dev/null > HOLDFILE.txt

function displayDate() {
  echo "Date/Time of Search: $(date)" >> OUTFILE.txt
}

function search() {
  echo "Searching for Files Larger Than 8Mb starting in $HOME"
  echo "Please Standby for the Search Results..."
  find ~ -size +8M 2>/dev/null > HOLDFILE.txt

  if [[ -z "$(wc -c < HOLDFILE.txt)" ]]; then
    echo "No files were found that are larger than 8MB"
    echo "Exiting..."
  else
    cat HOLDFILE.txt >> OUTFILE.txt
    echo "Number of files found: $(wc -l < HOLDFILE.txt)" >> OUTFILE.txt
  fi
}

function displayResults() {
  echo "These search results are stored in $HOME/OUTFILE.txt"
  echo "Search complete...Exiting..."
  cat OUTFILE.txt
}

displayDate
search
displayResults
