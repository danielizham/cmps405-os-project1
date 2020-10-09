#!/bin/bash

# Student 1  : Ali Mohammadian - 201807939 - Section B02
# Student 2  : Mohamed Daniel Bin Mohamed Izham - 201802738 - Section B01
# Course     : CMPS 405 - Operating Systems
# Assignment : Project 1
# Instructor : Heba D. M. Dawoud

# This subroutine outputs to stdout and the
# check.txt file the percentages of used and
# free memory every second for one minute.
disp_mem() {
    # Output header
    printf "Used Memory\tFree Memory\n" | tee -a check.txt

    for t in $(seq 1 60); do # Loop 60 times 1 sec apart (1 min total) 
	# Extract the line about the memory info from the free command
        mem_info=$(free | grep Mem) 

	# Divide the used and free values respectively by the total
	# and multiply by 100 to convert to percentage
        used=$(echo "$mem_info" | awk '{print $3/$2 * 100.0}')
        free=$(echo "$mem_info" | awk '{print $4/$2 * 100.0}')

	# Print out the percentages every second
        printf "%.2f%%\t\t%.2f%%\n" $used $free | tee -a check.txt
        sleep 1s
    done
}

# Call the subroutine
disp_mem
