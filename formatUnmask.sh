#!/bin/bash

# set mask and value to decode.
# numbers are separated into one number so that it's easy to treat
mask=(1 0 1 0 1 0 0 0 0 0 1 0 0 1 0)
value=(`cat - | fold -s15`)
decoded_format=(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)

for i in {1..15}
do
  if [ ${mask[i]} -eq ${value[i]} ]
  then
    decoded_format[i]=0
  else
    decoded_format[i]=1
  fi
done

echo ${decoded_format[@]}
