 #!/bin/sh
x=1
while [ $x -le $1 ]
 do
  echo $x
  ((x++))
  echo `iwlist 'wlan0' 'scan' | grep -e "Address: 00:"` >> $2 ;
  echo "iwlist AP List Dumped to file" $2;
  sleep 6 ;
 done
fold -w37 $2 > output.txt ;
echo "AP List saved in Output.txt file"
echo
cat output.txt
# echo `awk '!a[$0]++' output.txt`

