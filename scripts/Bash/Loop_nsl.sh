#!bin/bash
for i in 'splunk.com' 'fireeye.com' 'nmap.org'
do
    echo
    echo "---------------------------------------------"
    echo $i
    echo "---------------------------------------------"
    for j in 'A' 'NS' 'mx'
    do
        echo
        echo "+++++++++++++++++++"
        echo "NSLookup Type =" $j
        echo "+++++++++++++++++++"
        nslookup -type=$j $i
    done
done
