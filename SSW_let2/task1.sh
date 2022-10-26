#!/bin/bash

input=$1
length=${#input}
read -r -a array <<< $1
length=${#array[@]}

for(( i = 0; i < $length/2; i++)); do
  tmp=${array[$length-$i-1]}
  array[$length-$i-1]=${array[$i]}
  array[$i]=$tmp
done

for (( i = 0; i < $length; i++)); do
  echo -n ${array[$i]}
  echo -n " "
done
echo ""
exit 0
