#!/bin/bash

if [[ $# -ne 2 ]]
then
	echo "Error: Expected Two input parameters."
	echo "Usage: ./srcdiff.sh <originaldirectory> <comparisondirectory>"
	exit 1
fi

if [[ ! -d $1 ]]
then
	echo "Error: Input parameter #1 "$1" is not a directory."
	echo "Usage: ./srcdiff.sh <originaldirectory> <comparisondirectory>"
	exit 2
fi

if [[ ! -d $2 ]]
then
        echo "Error: Input parameter  #2 "$2" is not a directory."
        echo "Usage: ./srcdiff.sh <originaldirectory> <comparisondirectory>"
        exit 2
fi


if [[ $1 == $2 ]]
then
	echo "Error: Input parameters "$1" and "$2" are the same "
	echo "Usage: ./srcdiff.sh <originaldirectory> <comparisondirectory>"
	exit 2
fi


differcount=0

for file in $(ls $1)
do
	if [[ -f "$2/$file" ]]
	then
		diff $1/$file $2/$file &>null
		if [[ ${?} == 1 ]] 
		then
			echo " $2/$file differs."
			differcount=1
		fi
	else
		echo "$2/$file is missing"
		differcount=1
	fi
done
for file in $(ls $2)
do
        if [[ ! -f "$1/$file" ]]
        then
		echo "$1/$file is missing"
		differcount=1
	fi
done

if [[ $differcount -eq 1 ]]
then
	exit 3
else
	exit 0
fi


