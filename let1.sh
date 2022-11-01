#!/bin/bash

############ THIS IS A SCRIPT TO CODE/DECODE NUMBERS #############################################################
############ TO USE IT WRITE ./let1.sh -c [NUMBER] to code NUMBER or ./let1.sh -d [NUMBER] to decode NUMBER ######

# reading input into an array
while read -n 1 c; do
	array+=($c)
done <<< "$2"
# setting length of input array
length=${#array[@]}

# Argument check
while [ -n "$1" ]; do
	case "$1" in

	# Case for coding
	-c) # Main loop for coding
		# input check
		re='^[0-9]+$'
    if ! [[ $2 =~ $re ]]; then
      echo "WRONG INPUT, must be only numbers, while yours is $2"
      exit 1
    fi
		for(( i = 0; i < $length; i++ )); do
			# creating num as a single number
			num=$((${array[$i]}))
			# creating bin as a binary interpretation of num
			bin=$(echo "obase=2; $num" | bc)
			# transforming bin to an array bin_arr
			while read -n 1 c; do
				bin_arr+=($c)
			done <<< "$bin"
			# getting length of bin_arr
			result_len=${#bin_arr[@]}
		
			for((j = 0; j < $(($result_len - 1)); j++)); do
				echo -n "0"
			done
			echo -n "1"
			echo -n "$bin"

			# destroy previously used in loop variables
			unset bin bin_arr result_len num c
		done
		echo
		break;;

	# Case for decoding
	-d)
		# input check
		re='^[0-1]+$'
		if ! [[ $2 =~ $re ]]; then
			echo "WRONG INPUT, must be only 0 or 1, while yours is $2"
			exit 1
		fi

		# Main loop for decoding
		for(( i = 0; i < length;)); do
			# setting number of digits (minimum is 1)
			num_of_digits=1
			# finding true number of digits with moving iterator "i"
			while(( ${array[$i]} != "1" )); do
				num_of_digits=$(($num_of_digits+1))
				i=$(($i + 1))
			done
			i=$(($i + 1))

			# getting a string bin out of input with the size of number of digits
			for(( j = 0; j < num_of_digits; j++, i++)); do
				bin=$bin${array[$i]}
			done

		# transforming bin to a number
		bin_num=$(( $bin ))
		# tranforming binary bin_num into a decimal num
		num=$(echo "ibase=2; $bin_num" | bc)
		echo -n $num

		#destroy previously used in loop variables
		unset bin_num bin
	done
	echo
	break;;

	# all other cases
	*) echo "Wrong parameter: must be \"-c\" to encrypt or \"-d\" to decode! while yours is $1"
		exit 1;;
	esac
done

exit 0
