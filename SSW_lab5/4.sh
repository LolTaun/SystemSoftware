#!/bin/bash

# input check
re='^[0-9]+$'
if ! [[ $1 =~ $re ]]; then
  echo "$1 is not a number"
  exit 1
fi

# 1st loop to print the upper half of rhombus
index=$(($1-2))
for(( i = 0; i < $1; i++)); do
	#first subloop to print margin
	for(( j = 1; j < $index + 2; j++)); do
		echo -n " "
	done

	for(( j = 1; j < ($1 - $index); j++)); do
		echo -n "x "
	done
	index=$(($index-1))
	echo ""
done

# 2nd loop to print the lower half of rhombus
index=2
for(( i = $1-1; i > 0; i--)); do
	for(( j = $index; j > 1; j--)); do
		echo -n " "
	done
	for(( j = ($1 - $index + 2); j > 1; j--)); do
		echo -n "x "
	done
	index=$(($index+1))
	echo ""
done

exit 0
