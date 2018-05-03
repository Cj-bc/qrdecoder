#!/bin/bash
#
# checkformat.sh -- check QR code format.
#
# usage: echo <binary string> | checkformat.sh
# copyright (c) 2018 Cj-bc
#

# if verbose option was given, outputs info for human
if [ "$1" = "-v" ]
then
  verbose=1
  shift
fi

format_value="`cat - | tr -d ' '`"
# those are decided in JIS
FIX_LEVEL_LIST=(01 00 11 10)
MASK_PATTERN=(000 001 010 011 100 101 110 111)
MASK_STATEMENT=('( i + j ) % 2' 'i % 3' 'j % 3' '( i + j ) % 3' '( ( i / 2 ) + ( j / 3 ) ) % 2' '( i * j ) % 2 + ( i * j ) % 3' '( ( i * j ) % 2 + ( i * j ) % 3 ) % 2' '( i * j ) % 3 + ( i + j ) % 2')




Fix_value=`echo $format_value | head -c 2`
for i in ${FIX_LEVEL_LIST[@]}
do
  if [ $Fix_value -eq $i ]
  then
    FIX_LEVEL=$i
  fi
done

mask_val=`echo $format_value | head -c 5 | tail -c 3`
for ((i=0; i < 8; i++)) 
do
  if [ $mask_val -eq ${MASK_PATTERN[$i]} ]
  then
    MASK=${MASK_STATEMENT[$i]}
  fi
done

if [ $verbose ]
then
  echo "fix: $FIX_LEVEL"
  echo "mask: $MASK"
else
  echo "$FIX_LEVEL"
  echo "$MASK"
fi
