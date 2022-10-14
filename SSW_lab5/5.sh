#!/bin/bash

# Display file content with the number of lines in it

number=$(( 0 ))

while IFS= read -r line

do 
	echo "$line"
	number=$(( $number+1 ))
done < $1

echo "Total amount of lines: $number"

exit 0
