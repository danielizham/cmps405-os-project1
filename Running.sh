#!/bin/bash

# Student 1  : Ali Mohammadian - 201807939 - Section B02
# Student 2  : Mohamed Daniel Bin Mohamed Izham - 201802738 - Section B01
# Course     : CMPS 405 - Operating Systems
# Assignment : Project 1
# Instructor : Heba D. M. Dawoud


function sub1 {
  echo "*******************************************************"
  echo "$LOGNAME is currently logged in the linux system"
  echo "The current date and time on the linux system is $(date)"
  echo "$(who -b)"
  echo "The current working path is $(pwd)"
  echo "The current shell is $SHELL"
  echo "My home directory is $HOME with \# of files and directories in my home = $(ls -l ~ | wc -l)"
  echo "This Script will do something :)"
  echo "*******************************************************"
}

sub1

function sub2() {
  if [[ "$(date "+%H-%M")" = "23-59" ]]; then
    sleep 600
    ./Connectivity.sh
    ./Hardware.sh
    sleep 600
    ./FileSystem.sh
    ./Performance.sh
  fi
  trap "./Trap.sh" SIGINT SIGTERM
}

while true
do
  	sub2
done
