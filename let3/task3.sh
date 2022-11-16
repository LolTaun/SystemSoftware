#!/bin/bash

# input check
re='^[0-9]+$'
if ! [[ $1 =~ $re ]]; then
  echo "WRONG INPUT, must be only numbers, while yours is $1"
  exit 1
fi

# transferring input into an array
while read -n 1 c; do
  array+=($c)
done <<<$1

# loop to find permutation indexes (if we want to pull number)
for ((index = 0; index < ${#array[@]}; index++)); do
  smallest_index=$index
  for ((i = $(($index + 1)); i < ${#array[@]}; i++)); do
    if ((${array[$i]} <= ${array[$smallest_index]})); then
      smallest_index=$i
    fi
  done
  if (($smallest_index != $index)); then
    break
  fi
done

# ========== /loops to find permutation indexes (if we want to push number)\ ==========
biggest_index=0
#loop to find the biggest index that needs to be pushed
for(( i = 1; i < ${#array[@]}; i++ )); do
  if(( array[$biggest_index] < array[$i] && $(( $i - $biggest_index )) < 2 )); then
    biggest_index=$i
  fi
done

# loop to find where to push
for(( index2 =(($biggest_index + 1)); index2 < ${#array[@]}; index2++ )); do
  if(( ${array[$biggest_index]} < ${array[$index2]} )); then
    break
  fi
done
index2=$(( $index2 - 1 ))
# ========== \loops to find permutation indexes (if we want to push number)/ ==========

# =============== /if permutation is needed\ ===============
if (($index != ${#array[@]})); then
  # creating 2 result arrays for both cases (pull and push number)
  result=() # for pulling
  result2=() # for pushing

  # loop to fill result array with permuted numbers (pull)
  for ((i = 0; i < ${#array[@]}; i++)); do
    if (($i < $index)); then # (before insertion)
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
  # loop to fill result array with permuted numbers (push)
  for((i = 0; i < ${#array[@]}; i++)); do
    if(( $i < $index2 )); then
      if(( $i < $biggest_index )); then
        result2[$i]=${array[$i]}
      elif(( $i >= $biggest_index )); then
        result2[$i]=${array[$i + 1]}
      fi
    elif(( $i == $index2 )); then
      result2[$i]=${array[$biggest_index]}
    else
      result2[$i]=${array[$i]}
    fi
  done
# =============== \if permutation is needed/ ===============
# =============== /if permutation is not needed\ ===============
else
  echo "Couldn't find any possible permutation"
  echo -n "("
  for(( i = 0; i < ${#array[@]}; i++ )); do
    echo -n "${array[$i]}"
  done
  echo ", 0, 0)"
  exit 0
fi
# =============== \if permutation is not needed/ ===============


# ======= /loop to create string out of result array (with deletion of 0 at the beginning)\ =======
# variables not_zero1 not_zero2 are required to delete 0 at the beginning
not_zero1=0; not_zero2=0
for(( i = 0; i < ${#array[@]}; i++ )); do
  if(( $not_zero1 || $((${result[$i]})) != 0 )); then
    res1="$res1${result[$i]}"
    not_zero1=1
  fi
  if(( $not_zero2 || $((${result2[$i]})) != 0 )); then
    res2="$res2${result2[$i]}"
    not_zero2=1
    fi
done
unset not_zero1 not_zero2
# ======= \loop to create string out of result array (with deletion of 0 at the beginning)/ =======

# transferring strings to ints
Result1=$(($res1))
Result2=$(($res2))

# print result
if(( $Result1 <= $Result2 )); then
  echo -n "($Result1, $smallest_index, $index)"
else
  echo -n "($Result2, $biggest_index, $index2)"
fi

exit 0