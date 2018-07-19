#!/bin/bash

pci_id=$(lspci -vnn | grep NVIDIA | cut -c1-7)
#echo $pci_id

vendor_id=$(lspci -n)

i=1
j=1

for (( k = 1; k < 20; k++));
do
	a=$(echo $pci_id | cut -d' ' -f $i)
	b=$(echo $vendor_id | cut -d' ' -f $j)

	if [ "$a" == "$b" ]; then
		echo "$(echo $vendor_id | cut -d' ' -f $(echo "$j" + "2" | bc))"
		i=$(echo "$i" + "1"| bc)
		j=$(echo "$j" + "5"| bc)
	else
		j=$(echo "$j" + "5"| bc)
	fi
done
