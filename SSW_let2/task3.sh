#!/bin/bash
############ TASK3 [CODE PHRASES] ############

#reading input into an array
read -r -a array <<< $1
#creating variable index to lowercase letters later
index=0

#---{START}-----------/ MAIN LOOP \-------------
for elem in ${array[@]}; do
  # creating word as an array of chars
  while read -n 1 c; do word+=($c); done <<< "$elem"

  # creating an array that consists of indexes in ASCII table
  for(( i = 0; i < ${#word[@]}; i++ )); do
    code_word[$i]=$(printf "%d\n" "'${word[$i]}")
  done

  # Main SubLoop to transform words:
  for(( i = 0; i < ${#code_word[@]}; i++, index++)); do
        #{START}============/if [CHAR] (ASCII index 65-90)\==================
        if(( code_word[$i] > 64 && code_word[$i] < 91)); then
          # shift by 1
          code_word[$i]=$((${code_word[$i]}+1))
          # if it goes beyond ASCII index 90 (circular shift)
          if(( code_word[$i] > 90 )); then
            code_word[$i]=$((${code_word[$i]}-26))
          fi

          # to lowercase letters
          if(( $index % 2 )); then
            code_word[$i]=$((${code_word[$i]}+32))
          fi
        #{END}===============\if [CHAR] (ASCII index 65-90)/================

        #{START}=============/if [INT] (ASCII index 48-57)\==================
        elif((code_word[$i] > 47 && code_word[$i] < 58)); then
          # decrease number by 9
          code_word[$i]=$(( $(printf "%d\n" "'$((9-$(printf "\x$(printf %x ${code_word[$i]})")))") ))
        fi
        #{END}===============\if [INT] (ASCII index 48-57)/==================
  done
  # increasing index for next iterations
  index=$(($index+1))

  # Creating tmp_array which will become a modified word
  for (( i = 0; i < ${#code_word[@]}; i++)); do
    tmp_array+=$(printf "\x$(printf %x ${code_word[$i]})")
  done

  # add modified word to a global array
  answer_arr+=("${tmp_array[@]}")

  # destroy previously used in loop variables
  unset word code_word tmp_array
done
#---{END}-------------\ MAIN LOOP /-------------

#transform array of modified word into a single string
str=${answer_arr[@]}

# use task1.sh code to invert words and print output
length=${#str}
read -r -a array <<< $str
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
