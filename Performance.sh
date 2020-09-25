#!/bin/bash

# Student 1  : Ali Mohammadian - 201807939 - Section B02
# Student 2  : Mohamed Daniel Bin Mohamed Izham - 201802738 - Section B01
# Course     : CMPS 405 - Operating Systems
# Assignment : Project 1
# Instructor : Heba D. M. Dawoud

create_stats() {
	# this subroutine backs up information about the current
	# status of this computer and archives it

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
	# this subroutine makes a copy of each file in the home
	# directory with a permission u=rw in a backup directory.
	# Then, their permissions are modified to u=r.

	date_time_now="$(date +"%y%m%d%H%M%S")"
	mkdir "$date_time_now"
	find ~ -type f \                 # find all files only
		\( -perm -600 \) \       # that have at least 600
		-and \
		\( -not -perm -700 \) \  # but not more than 700
		# then copy them to the newly created directory
		-exec cp '{}' "$date_time_now"/ +  
	
	# for this directory and its content, change only the owner
	# permission with rw to r (igore the group and others).
	find "$date_time_now" \          # find all dirs and files
		\( -perm -600 \) \       # that have at least 600
		-and \
		\( -not -perm -700 \) \  # but not more than 700
		-exec chmod u=r '{}' +	 # change owner perm to r
}

display_info() {
	# this subroutine displays to the console for the user
	# the conclusion of the first two subroutines.

	# count only files that have u=r (do not count dirs 
	# nor files with u=-, u=rwx, u=rw, u=wx, u=w or u=x).
	echo -n "The number of files with u=r in dir "$date_time_now"/: "
	find "$date_time_now" -type f \  # find only files
		\( -perm -400 \) \	 # that have at least 400
		-and \
		\( -not -perm -600 \) \  # but not more than 600
		| wc -l                  # then count them
	echo "Backing up performance data has completed. Exiting..."
}

create_stats
backup_rw_files
display_info
