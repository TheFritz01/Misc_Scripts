#!/bin/bash

## Script name:  deleteOldFiles.sh
## Author:       Aaron Stovall
## Date:  	 06/20/2019
##
## Description:  Checks Files in a Specified Directory to see if they are older than
##		 the specified number of days.  
##
## Dependencies: JAMF Enrolled Mac
##				  

# JAMF Script Option Variables
directoryPath="$4"
fileAge="$5"

# Lists Files that meet the fileAge criteria in a given directory
oldPackages=$( find "${4}" -type f -mtime +${5}d -exec basename {} \; | xargs -0 -n1 )

# Check if any old packages were found. If so, delete them.
if [[ ! "$oldPackages" ]]; then
	echo "No Old Packages found"
	exit 0
else
	echo "The following packages are over $5 days old:"
	echo "$oldPackages"
	echo ""
	echo "Now deleting all files over $5 days old from the JAMF Waiting Room"
	find "${4}" -type f -mtime +${5}d -print0 | xargs -0 rm
	echo ""
	echo "Files Deleted"
fi

exit 0

