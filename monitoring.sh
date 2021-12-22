#!/bin/bash
architecture=$(uname -a)
nbphycpu=$(getconf _NPROCESSORS_ONLN)
nbvircpu=$(grep "^processor" /proc/cpuinfo | wc -l)
ramuse=$(free -m | grep -i mem | awk '{print $3}')
ramfree=$(free -m | grep -i mem | awk '{print $2}')
rampct=$(free -m | grep -i mem | awk '{printf("%.1f"), $3/$2*100}')
dskuse=$(df -h --total | grep -i total | awk '{print $3}')
dskfree=$(df -h --total | grep -i total | awk '{print $2}')
dskptc=$(df -h --total | grep -i total | awk '{printf("%.1f"), $3/$2*100}')
cpuuse=$(uptime | awk '{print $10}' | head -c 4 | awk '{printf("%.1f"), $1*100}')
lstbootdate=$(who -b | awk '{print $3}')
lstboothour=$(who -b | awk '{print $4}')
lvmact=yes
if [ $(lsblk | grep LVM | wc -l) = 0 ]
then
	lvmact=no
fi
nbtcp=$(netstat -nt | grep ESTABLISHED | wc -l)
nbusers=$(users | wc -w)

echo "#Architecture: $architecture"
echo "#CPU physical: $nbphycpu"
echo "#CPU virtual: $nbvircpu"
echo "#RAM usage: $ramuse / $ramfree MB ($rampct%)"
echo "#DISK usage: $dskuse / $dskfree ($dskptc%)"
echo "#CPU usage: $cpuuse%"
echo "#Last boot: $lstbootdate $lstboothour"
echo "#LVM actif: $lvmact"
echo "#Connexions TCP: $nbtcp ETABLISHED"
echo "#User log: $nbusers"

