#!/bin/bash
# scotti@uniss.it 2016/08/19
# **** exFAT does not support Symbolic Links!
# Saving from my hard-disk I was loosing the info that all my 99 symlnks contained.
# So I tried to back-up transferring the info to a text file:
#     with the same name as the original symlnk with an extra extension (the name of the script!)
#     containing the symlnk target path
if [[ (-z $1) || (-z $2) || (-z $3) ]]; then
	echo "*** Usage: $0 <list_of_symlnks_to_save> <source_path_to_add> <dest_path_to_add>"
	exit 1
fi
ext=$0
echo "extension $ext"
list=$1
source=$2
destin=$3
i=0
printf "Processing line: "
while read -r line
        do
	infile=$source/$line
	outfile=$destin/$line.symlink2txt
        i=$(($i+1))
	if [ -L "$infile" ] ; then
		target="$(readlink -- "$infile")"
		printf "$i,"
	else
		echo "NOT a Symbolic link: $infile"
	fi
#	if [ $i -ge 2 ]; then break; fi
done < "${list:-/dev/stdin}"
echo finished

