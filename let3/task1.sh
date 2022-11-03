#!/bin/bash

#declare -a s1="( $1 )"
#declare -a s2="( $2 )"

while read -n 1 c; do 
	s1+=($c); 
done <<< "$1"

readarray -td '' s1_sorted < <(printf '%s\0' "${s1[@]}" | sort -z -u)

while read -n 1 c; do s2+=($c); done <<< "$2"
readarray -td '' s2_sorted < <(printf '%s\0' "${s2[@]}" | sort -z -u)

for(( i = 0; i < ${#s1_sorted[@]}; i++ )); do 
	list+=(${s1_sorted[$i]}); 
done

for(( i = 0; i < ${#s2_sorted[@]}; i++ )); do 
	list+=(${s2_sorted[$i]}); 
done

readarray -td '' sorted_list < <(printf '%s\0' "${list[@]}" | sort -z -u)

for((i=0; i < ${#sorted_list[@]}; i++ )); do echo -n ${sorted_list[$i]}; done
echo

exit 0
