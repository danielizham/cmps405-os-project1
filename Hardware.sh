#!/bin/bash

# Student 1  : Ali Mohammadian - 201807939 - Section B02
# Student 2  : Mohamed Daniel Bin Mohamed Izham - 201802738 - Section B01
# Course     : CMPS 405 - Operating Systems
# Assignment : Project 1
# Instructor : Heba D. M. Dawoud

# This subroutine outputs to stdout and the check.txt file
# the used and free memory values in percentages.
disp_mem() {
	printf "Used Memory\tFree Memory\n" | tee -a check.txt
	for t in $(seq 1 60); do
		mem_info=$(free)
		used=$(echo "$mem_info" | grep Mem | awk '{print $3/$2 * 100.0}')
		free=$(echo "$mem_info" | grep Mem | awk '{print $4/$2 * 100.0}')
		printf "%.2f%%\t\t%.2f%%\n" $used $free | tee -a check.txt
		sleep 1s
	done
}

disp_mem
