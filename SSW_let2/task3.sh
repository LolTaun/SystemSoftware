#!/bin/bash

declare -a array="( $1 )"

for elem in $array; do
  while read -n 1 c; do word+=($c); done <<< "$elem"
  for(( i = 0; i < ${#word[@]}; i++ )); do
    code_word[$i]=$(printf "%d\n" "'${word[$i]}")
  done


  for(( i = 0; i < ${#code_word[@]}; i++)); do
    code_word[$i]=${code_word[$i]}-1
  done

for (( i = 0; i < ${#code_word[@]}; i++)); do
  echo ${code_word[$i]}
done
done

exit 0
