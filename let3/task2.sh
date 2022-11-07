#!/bin/bash

# swap function to swap strings
swap() {
  tmp=("${word1[@]}")
  word1=("${word2[@]}")
  word2=("${tmp[@]}")
  unset tmp
}

# transferring program input into an array "input"
read -r -a input <<< $1

# Main loop
for ((i = 1; i < ${#input[@]}; i++)); do
  # creating arrays that consist of chars
  while read -n 1 c; do
    word1+=($c)
  done <<<"${input[$(($i - 1))]}"
  while read -n 1 c; do
    word2+=($c)
  done <<<"${input[$i]}"

  # swapping words
  if ((${#word1[@]} > ${#word2[@]} && $i % 2)); then
    swap $word1 $word2
  elif ((${#word1[@]} < ${#word2[@]} && !(($i % 2)))); then
    swap $word1 $word2
  fi

  ##{START}####/CODE BLOCK TO UPPERCASE OR LOWERCASE LETTERS\#####

    # case for odd index
  if (( !(($i % 2)) )); then
    for ((j = 0; j < ${#word1[@]}; j++)); do
      symbol_code=$(printf "%d\n" "'${word1[$j]}")
      if (($symbol_code > 96 && $symbol_code < 123)); then
        symbol_code=$(($symbol_code - 32))
      fi
      word1[$j]=$(printf "\x$(printf %x $symbol_code)")
    done

    #case for even index
  elif ((i % 2)); then
    for ((j = 0; j < ${#word1[@]}; j++)); do
      symbol_code=$(printf "%d\n" "'${word1[$j]}")
      if (($symbol_code > 64 && $symbol_code < 91)); then
        symbol_code=$(($symbol_code + 32))
      fi
      word1[$j]=$(printf "\x$(printf %x $symbol_code)")
    done
  fi
  ##{END}####\CODE BLOCK TO UPPERCASE OR LOWERCASE LETTERS/######

  # push swapped words into an array back
  input[$(($i - 1))]=${word1[@]}
  input[$i]=${word2[@]}

  # print word which will not be swapped
  for ((j = 0; j < ${#word1[@]}; j++)); do
    echo -n ${word1[$j]}
  done
  echo -n " "
  # Code block for the last word
  if (($i == ((${#input[@]} - 1)))); then
    # loop to lowercase or uppercase and then print last word
    for ((j = 0; j < ${#word2[@]}; j++)); do
      symbol_code=$(printf "%d\n" "'${word2[$j]}")
      # uppercase
      if (($i % 2)); then
        if (($symbol_code > 96 && $symbol_code < 123)); then
          symbol_code=$(($symbol_code - 32))
        fi
      else # lowercase
        if (($symbol_code > 64 && $symbol_code < 91)); then
          symbol_code=$(($symbol_code + 32))
        fi
      fi
      # print last word
      if(($symbol_code != 0)); then
        word2[$j]=$(printf "\x$(printf %x $symbol_code)")
      fi
      echo -n ${word2[$j]}
    done
  fi

  unset word1 word2 c
done
echo
exit 0
