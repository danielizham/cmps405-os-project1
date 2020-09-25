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
	cp Phase1.tar.gz "$time_now"/
}

backup_rw_files() {
	date_time_now="$(date +"%y%m%d%H%M%S")"
	mkdir "$date_time_now"
	find ~ -type f -perm 600 -exec cp '{}' "$date_time_now"/ +
	
	# for this directory and its content, change only the owner
	# permission with rw to r (igore the group and others).
	find "$date_time_now" \          # find all dirs and files
		\( -perm -600 \) \       # that have at least 600
		-and \
		\( -not -perm -700 \) \  # but not more than 700
		-exec chmod u=r '{}' +	 # change owner perm to r
}

display_info() {
	find "$date_time_now"/ -maxdepth 1 -mindepth 1 -perm -444 | wc -l # read permission for owner only or all?
	echo "Backing up performance data has completed. Exiting..."
}

create_stats
backup_rw_files
display_info
