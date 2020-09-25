#!/bin/bash

# Student 1  : Ali Mohammadian - 201807939 - Section B02
# Student 2  : Mohamed Daniel Bin Mohamed Izham - 201802738 - Section B01
# Course     : CMPS 405 - Operating Systems
# Assignment : Project 1
# Instructor : Heba D. M. Dawoud


function header() {
  # This subroutine will display the header and provides basic information for the user

  echo "*******************************************************"
  echo "$LOGNAME is currently logged in the linux system"
  echo "The current date and time on the linux system is $(date)"
  echo "$(who -b)"
  echo "The current working path is $(pwd)"
  echo "The current shell is $SHELL"
  echo "My home directory is $HOME with # of files and directories in my home = $(ls -1A ~ | wc -l)"
  echo "This Process will Retrieve and Display Information about Hardware, Connectivity, File Systems and Performance Every 24 hours starting at 23:59"
  echo "*******************************************************"
  echo "Waiting for results..."
}

# Call header Subroutine
header

function runScripts() {
  # The if statment will be executed in every iteration to check whether time matches
  if [[ "$(date "+%H-%M-%S")" = "23-59-00" ]]; then
    ./Connectivity.sh
    ./Hardware.sh
    sleep 600 # wait for 10 minutes
    ./FileSystem.sh
    ./Performance.sh
  fi
  # The trap command to catch and ignore interrupts, call Trap.sh and display a message
  trap "./Trap.sh" SIGINT SIGTERM
}

while true
do
    # Anything here will be running infinitely
  	runScripts
done
