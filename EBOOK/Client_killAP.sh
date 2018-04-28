#!/bin/bash
c=1
while [ $c -le $1 ]
do
  sleep 10 ;
  killall airbase-ng ;
  echo $c "Killing airbase-ng Process Done";
  ((c++))
done

