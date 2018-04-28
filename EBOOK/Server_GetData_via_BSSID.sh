 #!/bin/sh 
 fold -w37 $1 > AP_Info_list.txt;
 awk {'print $5'} AP_Info_list.txt > BSSID_List.txt;
 
  for ops in `awk '!a[$0]++' BSSID_List.txt | xxd -p`; 
	do
	ops1=`echo $ops | xxd -r -p`
	ops2=`echo $ops | xxd -r -p | xxd -r -p`
	echo $ops1 "==>" $ops2
	done
   echo
   echo "[;)] your Injected Bytes via Mac Addresses: "
   echo `awk '!a[$0]++' BSSID_List.txt`
   echo
   echo "[;o] your Data : "
   echo
   echo `awk '!a[$0]++' BSSID_List.txt | xxd -r -p`
