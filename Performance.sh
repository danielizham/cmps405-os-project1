#!/bin/bash

# Student 1  : Ali Mohammadian - 201807939 - Section B02
# Student 2  : Mohamed Daniel Bin Mohamed Izham - 201802738 - Section B01
# Course     : CMPS 405 - Operating Systems
# Assignment : Project 1
# Instructor : Heba D. M. Dawoud

# for testing purposes
echo TESTING: Performance.sh was called!

create_stats() {
	du --max-depth=1 --human-readable ~ | sort --human-numeric-sort --reverse --output=Disk_Usage.txt
	dmesg -H > Message_Log.txt
	cat /proc/cpuinfo > cpu_inf.txt
	cat Message_Log.txt | wc -w > Message_Count.txt
	tar zcf Phase1.tar.gz Disk_Usage.txt cpu_inf.txt Message_Count.txt
	local time_now="$(date +"%H%M%S")"
	mkdir "$time_now"
	mv Phase1.tar.gz "$time_now"/
}

create_stats

