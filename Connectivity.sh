#!/bin/bash

# Student 1  : Ali Mohammadian - 201807939 - Section B02
# Student 2  : Mohamed Daniel Bin Mohamed Izham - 201802738 - Section B01
# Course     : CMPS 405 - Operating Systems
# Assignment : Project 1
# Instructor : Heba D. M. Dawoud

function checkConnectivity() {
  # Test Connectivity with ping command
  if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
    echo "The System is Connected to the Internet. Pinging..."
    # Get the ip of the default gateway
    # grep the line with "default" word and print the 3rd column of that line
    DEFAULT_ROUTE=$(ip route show default | awk '/default/ {print $3}')
    # Ping the gateway with 8 packets and save in file
    ping -c 8 $DEFAULT_ROUTE > PINGRESULTS.txt
    echo "Done! results were saved in PINGRESULTS.txt"
  else
    echo "Not Connected to the internet. The system will reboot in 15 seconds..."
    sleep 15
    # Reboot with -r option
    shutdown -r now
  fi
}

function checkSpeeds() {
  # Gets the Ethernet Network interface in order to use in the next command.
  # How: separate columns/fields using ":". Find lines that do not contain
  # the "<regex>". Print the second field (interface name) of the found line.
  netName="$(ip link | awk -F: '$0 !~ "lo|vir|wl|^[^0-9]" {print $2; getline}')"

  # Searches in the content of /proc/net/dev and extracts information about 
  # current download and upload speed, Tested with ping.
  # How: find the change in received bytes in 1 second (download speed) 
  # and convert to KBps.
  # Do the same with transmitted bytes (upload speed).
  awk '{i++; recv[i]=$1; trans[i]=$2}; \
		  END{print "Current Download Speed: " (recv[2]-recv[1])/1000 " KBps \
		  \nCurrent Upload Speed: " (trans[2]-trans[1])/1000 " KBps"}' \
		  <(cat /proc/net/dev | grep "$netName" | awk -F' ' '{print $2 " " $10}'; \
		  sleep 1; \
		  cat /proc/net/dev | grep "$netName" | awk -F' ' '{print $2 " " $10}') \
		  > UPDOWN.txt
}

checkConnectivity
checkSpeeds
