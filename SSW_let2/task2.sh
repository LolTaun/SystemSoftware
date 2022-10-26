#!/bin/bash

#addLetters(){
#
#}

if [ -z $1 ]; then
  echo "z"
  exit 0
  fi

#printf "%d\n" \'a
#printf "\x$(printf %x 98)"
#echo ""
index=0
for char in $*; do
  arr[$index]=$char
  index=$(($index+1))
done


length=${#arr[@]}
sum=0

for (( i = 0; i < $length; i++)); do
  tmp=$(printf "%d\n" "'${arr[$i]}")
  sum=$(($sum+$tmp))
done

sum=$((($sum % 96) + 96))
if(( sum > 122 )); then
  sum=$(($sum-26))
fi

echo $(printf "\x$(printf %x $sum)")




exit 0