#!/bin/bash

pci_id=$(lspci -vnn | grep NVIDIA | cut -c1-7)
vender_id=$(lspci -n)

i=1
j=1

if [ -e /etc/modprobe.d/vfio.conf ];
then
	mv /etc/modprobe.d/vfio.conf /etc/modprobe.d/vfio.conf.bak
fi

for (( k = 1; k < 100; k++));
do
	a=$(echo $pci_id | cut -d' ' -f $i)
	b=$(echo $vender_id | cut -d' ' -f $j)

	if [ "$a" == "$b" ];
	then
		if [ -n "$b" ];
		then
			echo "options vfio-pci ids=$(echo $vender_id | cut -d' ' -f $(echo "$j" + "2" | bc)) disable_vga=1" >> /etc/modprobe.d/vfio.conf
			i=$(echo "$i" + "1"| bc)
			j=$(echo "$j" + "5"| bc)
		fi
	else
		j=$(echo "$j" + "5"| bc)
	fi
done
