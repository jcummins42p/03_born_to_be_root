#! /bin/bash

disku=$(df -m | awk '/^\/dev/ && !/\/boot\// { tdu += $3 } END { print tdu }')
diskt=$(df -m | awk '/^\/dev/ && !/\/boot\// { tdu += $2 } END { print tdu }')
diskp=$(awk "BEGIN {printf \"%.2f\", ($disku / $diskt) * 100}")

echo "
#Architecture	: $(uname -a)
#CPU physical	: $(awk ' /cores/ {print $NF} ' /proc/cpuinfo | uniq)
#vCPU		: $(awk ' /siblings/ {print $NF} ' /proc/cpuinfo | uniq)
#Memory Usage	: $(free -m | awk ' /Mem:/ {printf "%d/%dMB (%.2f%%)", $3, $2, $3/$2*100}')
#Disk Usage	: ${disku}/${diskt}MB (${diskp}%)
#CPU usage	: $(top -bn1 | awk '/Cpu\(s\):/ {print $2+$4+$6 "%"}')
#Last Boot	: $(who -b | awk '{print $(NF-1), $(NF)}')
#LVM Active	: $(lsblk | awk '{tlvm="no"; if ($3=="lvm") tlvm="yes";} END {print tlvm}')
#TCP Connections: $(ss -neopt state ESTABLISHED | wc -l) ESTABLISHED
#User log	: $(users | wc -l)
#Network	: IP $(hostname -I) ($(ip link show | awk '/ether/ {print $2}'))
#Sudo		: $(journalctl | awk /COMMAND/ | wc -l) cmd
"

