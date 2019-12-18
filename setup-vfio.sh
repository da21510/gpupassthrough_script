#!/bin/bash

pci_id=$(lspci -vnn | grep "Advanced Micro Devices\|NVIDIA" | cut -c1-7)
vender_id=$(lspci -n)

i=1
j=1
sum=0

if [ -e /etc/modprobe.d/vfio.conf ];
then
	mv /etc/modprobe.d/vfio.conf /etc/modprobe.d/vfio.conf.bak
fi

echo -n "options vfio-pci ids=" >> /etc/modprobe.d/vfio.conf

for (( k = 1; k < 500; k++));
do
	a=$(echo $pci_id | cut -d' ' -f $i)
	b=$(echo $vender_id |cut -d' ' -f $j | cut -c1-7)

	if [ "$a" == "$b" ];
	then
		if [ -n "$b" ];
		then
			if [ "$sum" == "0" ];
			then
				echo -n "$(echo $vender_id | cut -d' ' -f $(echo "$j" + "2" | bc))" >> /etc/modprobe.d/vfio.conf
				i=$(echo "$i" + "1"| bc)
				j=$(echo "$j" + "1"| bc)
				sum=$(echo "$sum" + "1"| bc)
			else
				echo -n ",$(echo $vender_id | cut -d' ' -f $(echo "$j" + "2" | bc))" >> /etc/modprobe.d/vfio.conf
				i=$(echo "$i" + "1"| bc)
				j=$(echo "$j" + "1"| bc)
			fi
		fi
	else
		j=$(echo "$j" + "1"| bc)
	fi
done

echo -n " disable_vga=1" >> /etc/modprobe.d/vfio.conf
