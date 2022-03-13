#!bin/bash
ws=(splunk.com fireeye.com nmap.org)
nmtype=(A NS mx)
for i in "${ws[@]}"
do
    echo "---------------------------------------------"
    echo $i
    echo "---------------------------------------------"
    for j in "${nmtype[@]}"
    do
        echo " "
        echo "+++++++++++++++++++"
        echo "NSLookup Type =" $j
        echo "+++++++++++++++++++"
        nslookup -type=$j $i
    done
done