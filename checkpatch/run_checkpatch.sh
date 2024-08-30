#!/bin/bash

CHECKPATCH_CMD="./checkpatch.pl --terse --file --no-tree --ignore SPDX_LICENSE_TAG"
dir=$1

function do_run_checkpatch() {
for file in "$1"/*
do
	if [ ! -d "${file}" ]; then
		if [ ${file##*.} == "c" ] || [ ${file##*.} == "h" ]  \
		   || [ ${file##*.} == "s" ] || [ ${file##*.} == "S" ] \
		   || [ ${file} == "Makfile" ] || [ ${file} == "makefile" ]
		then
			echo ${file}
			$CHECKPATCH_CMD ${file}
		fi
	else
		do_run_checkpatch "${file}"
	fi
done
}

do_run_checkpatch $dir
