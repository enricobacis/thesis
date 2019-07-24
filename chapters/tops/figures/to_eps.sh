#!/bin/bash

if [ $# -eq 0 ]
then
  FILES=$(find . -iname '*.pdf' -not -iname '*converted-to*')
else
  FILES="$@"
fi

for f in $FILES
do
    printf "Converting $f -> ${f%.pdf}.eps ... " ;
    p=`realpath $f` ;
    inkscape $p --export-eps=${p%.pdf}.eps ;
    echo "done" ;
done
