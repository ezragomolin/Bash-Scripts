#!/bin/bash


if [[ $# -ne 2 ]]
then
	echo "Error: Expected Two input parameters."
	echo "Usage: ./backup.sh <backupdirectory> <fileordirtobackup>"
	exit 1 
fi


if [[ ! -d $1 ]]
then
	echo "Error: Backup directory '$1'  does not exist."
	echo "Usage: ./backup.sh <backupdirectory> <fileordirtobackup>"
	exit 2
fi

if ([ ! -d $2 ] && [ ! -f $2 ])
then
	echo "Error: The file or directory '$2' does not exist."
	exit 2
fi

if [[ $1 == $2 ]]
then
	echo "Error: The directory '$1' is the same as '$2'"
	exit 2
fi

f="$(basename -- $2)"

date=$(date +"%Y%m%d")

if [[ -f "${1}/${f}.${date}.tar" ]]
then
	echo " Backup file '${1}/${f}.${date}.tar' already exists. Overrite? (y/n)"
       	read  answer
	if [ $answer == "n" ]
	then
		
        	echo "Error: The file already exists. Not overwriting."
		exit 3
	fi
		 	
fi



tar -cvf  ${1}/${f}.${date}.tar $2  &>/dev/null 
exit 0

