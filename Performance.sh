#!/bin/bash

# Student 1  : Ali Mohammadian - 201807939 - Section B02
# Student 2  : Mohamed Daniel Bin Mohamed Izham - 201802738 - Section B01
# Course     : CMPS 405 - Operating Systems
# Assignment : Project 1
# Instructor : Heba D. M. Dawoud

# NOTE: This script may take a noticeable few seconds due to copying
# and changing permissions of a large number of files in the second
# subroutine. This is much more so if the script is placed in the
# $HOME directory where recursion may occur.

# This subroutine backs up information about the current
# status of this computer and archives it
create_stats() {
	# disk usage of home dir
	du --max-depth=1 --human-readable ~ \
		| sort --human-numeric-sort --reverse --output=Disk_Usage.txt
	# kernel output
	dmesg -H > Message_Log.txt
	# information on the CPU
	cat /proc/cpuinfo > cpu_inf.txt
	# word count of the kernel output
	cat Message_Log.txt | wc -w > Message_Count.txt
	# compress the files above
	tar zcf Phase1.tar.gz Disk_Usage.txt cpu_inf.txt Message_Count.txt
	# copy the compressed file to a folder with current time as its name
	local time_now="$(date +"%H%M%S")"
	mkdir "$time_now"
	cp Phase1.tar.gz "$time_now"/
}

# This subroutine makes a copy of each file in the home
# directory with a permission u=rw in a backup directory.
# Then, their permissions are modified to u=r.
backup_rw_files() {
	date_time_now="$(date +"%y%m%d%H%M%S")"
	mkdir "$date_time_now"
	find ~ -type f \
		\( -perm -600 \) \
		-and \
		\( -not -perm -700 \) \
		-exec cp '{}' "$date_time_now" ';' \
	        2> /dev/null	
		# find all files only
	        # that have at least 600
		# but not 700 or more (i.e u=rw but g & o can be anything)
		# then copy them to the newly created directory
	
	# for this directory and its content, change only the owner
	# permission with rw to r (igore the group and others).
	find "$date_time_now" \
		\( -perm -600 \) \
		-and \
		\( -not -perm -700 \) \
		-exec chmod u=r '{}' +
		# find all dirs and files
	        # that have at least 600
		# but not 700 or more (i.e u=rw but g & o can be anything)
		# change owner perm to r
}

# This subroutine displays to the console for the user
# the conclusion of the first two subroutines.
display_info() {
	# count only files that have u=r (do not count dirs 
	# nor files with u=-, u=rwx, u=rw, u=wx, u=w or u=x).
	echo -n "The number of files with u=r in dir "$date_time_now"/: "
	find "$date_time_now" -type f \
		\( -perm -400 \) \
		-and \
		\( -not -perm -600 \) \
		| wc -l
		# find only files
		# that have at least 400
		# but not 600 or more (i.e u=r but g & o can be anything)
		# then count them
	echo "Backing up performance data has completed. Exiting..."
}

# Call all subroutines
create_stats
backup_rw_files
display_info
