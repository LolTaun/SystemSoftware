#!/bin/bash

# Digital art bash script ;D
# (Rhombus)

if (( $1 < 3 ))
then
  echo "Size must be more than 2, while the current size is $1"
  exit 1
fi
half=$(($1 / 2))
is_odd=$(($1 % 2))

if(($is_odd))
 then
  for ((i = 1; i <= $1; i+=2))
  do
    margin=$(($1-$i))
    for ((j = 0; j < $margin/2; j++))
    do
      echo -n " "
    done
    for((j = 0; j < $i; j++))
    do
      echo -n "."
    done
    for((j=$margin/2+1; j<=$margin; j++))
    do
      echo -n " "
    done
    echo " "
  done
  for (( i = $1 - 2; i > 0; i-=2 ))
   do
     margin=$(($1-$i))
         for ((j = 0; j < $margin/2; j++))
         do
           echo -n " "
         done
         for((j = 0; j < $i; j++))
         do
           echo -n "."
         done
         for((j=$margin/2+1; j<=$margin; j++))
         do
           echo -n " "
         done
         echo ""
   done

  else
    for(( i = 1; i <= $1; i++))
    do
      for(( j = $half + 1; j <= $1; j++))
      do
        if (( $i <= $half ))
        then
          if (( $1 - $i >= $j ))
          then
            echo -n " "
          else
            echo -n ".."
          fi
        else
          if(( $j <= $i ))
          then
            echo -n " "
          else
            echo -n ".."
          fi
        fi
      done
      echo ""
    done
fi

exit 0
