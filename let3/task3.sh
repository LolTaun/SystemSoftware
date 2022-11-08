#!/bin/bash

# input check
re='^[0-9]+$'
if ! [[ $1 =~ $re ]]; then
  echo "WRONG INPUT, must be only numbers, while yours is $1"
  exit 1
fi
# assigning helpful variable
number_of_zeros=0
found_digit=0
# transferring input into an array
while read -n 1 c; do
  array+=($c)
done <<<$1

# loop to find special numbers with 2 or more '0' at the start
for ((i = 0; i < ${#array[@]}; i++)); do
  if((!$found_digit)); then # when the first digit (except of '0') was not found
    if(( $((${array[$i]})) != 0 )); then # if the first digit (except of '0') was found
      found_digit=1 # set true
      smallest_index=$i # set smallest index (temporary or finally)
    fi
  else # when the first digit (except of '0') was found
    if(( $((${array[$i]})) == 0 )); then # if '0' was found after the first digit
      number_of_zeros=$(($number_of_zeros + 1)) # increase number of found zeros
    else break # if digit other than '0' was found
    fi
  fi
done
unset found_digit # delete var


if(( $number_of_zeros > 1 )); then # (IN CASE WITH 2 or more '0' at the start)
  index=$(($number_of_zeros + $smallest_index))
  else # (IN CASE WITHOUT '0' at the start)
    # loop to find permutation indexes (from and where to insert)
    for ((index = 0; index < ${#array[@]}; index++)); do
      smallest_index=$index
      for ((i = $(($index + 1)); i < ${#array[@]}; i++)); do
        if ((${array[$i]} < ${array[$smallest_index]})); then
          smallest_index=$i
        fi
      done
      if (($smallest_index != $index)); then
        break
      fi
    done

fi


if (( $index != ${#array[@]})); then # if permutation is needed
  # creating an answer array
  result=()
  # inserting digits in a result
  for ((i = 0; i < ${#array[@]}; i++)); do
    if(( $i >= $smallest_index && $i < $index )); then
      result[$i]=0
    elif (($i < $index)); then # (before insertion)
      result[$i]=${array[$i]}
    elif (($i == $index)); then # (inserted smallest digit)
      result[$i]=${array[$smallest_index]}
    elif (($i > $index)); then # (after inserted digit)
      if (($i <= $smallest_index)); then # (after inserted digit and before previous location)
        result[$i]=${array[$(($i - 1))]}
      elif (($i > $smallest_index)); then # (after previous location of smallest digit)
        result[$i]=${array[$i]}
      fi
    fi
  done
else # if there is no need in permutation
  echo "Couldn't find any possible permutation"
  result=("${array[@]}")
  index=0
  smallest_index=0
fi

# print result
echo -n "("
for ((i = 0; i < ${#result[@]}; i++)); do
  echo -n ${result[$i]}
done
echo ", $smallest_index, $index)"

exit 0
