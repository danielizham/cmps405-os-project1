#!/bin/bash

# Student 1  : Ali Mohammadian - 201807939 - Section B02
# Student 2  : Mohamed Daniel Bin Mohamed Izham - 201802738 - Section B01
# Course     : CMPS 405 - Operating Systems
# Assignment : Project 1
# Instructor : Heba D. M. Dawoud

# To initialize the following files
cat /dev/null > OUTFILE.txt
cat /dev/null > HOLDFILE.txt

# This subroutine appends the date and time of the search as the first line of the OUTFILE.txt
function displayDate() {
  echo "Date/Time of Search: $(date)" >> OUTFILE.txt
}

# This subroutine will search the home directory
function search() {
  echo "Searching for Files Larger Than 8Mb starting in $HOME"
  echo "Please Standby for the Search Results..."
  # To find all files larger than 8M and send results to the file; Errors are redirected to /dev/null
  find ~ -size +8M 2>/dev/null > HOLDFILE.txt

  if [[ ! -s "HOLDFILE.txt" ]]; then
    # If no files were found, HOLDFILE.txt will be an empty string
    echo "No files were found that are larger than 8MB"
    echo "Exiting..."
  else
    # Search results will be appended to another file
    cat HOLDFILE.txt >> OUTFILE.txt
    # Append the number of files at the end of the file
    echo "Number of files found: $(wc -l < HOLDFILE.txt)" >> OUTFILE.txt
  fi
}

# This subroutine will display all results save in OUTFILE.txt
function displayResults() {
  echo "These search results are stored in $HOME/OUTFILE.txt"
  echo "Search complete...Exiting..."
  cat OUTFILE.txt
}

# Call all subroutines
displayDate
search
displayResults
