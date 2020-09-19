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

backup_rw_files() {
	date_time_now="$(date +"%y%m%d%H%M%S")"
	mkdir "$date_time_now"
	find ~ -type f -perm 600 -exec cp '{}' "$date_time_now"/ +
	local owner="$(stat -c "%U" "$date_time_now"/)"
	find "$date_time_now" -user "$owner" -exec chmod 400 '{}' +
}

display_info() {
	find "$date_time_now"/ -maxdepth 1 -mindepth 1 -perm -444 | wc -l # read permission for owner only or all?
	echo "Backing up performance data has completed. Exiting..."
}

create_stats
backup_rw_files
display_info
