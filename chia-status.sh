#!/bin/bash
# @tildasec
# check network and wallet status of the Chia client

#find Chia dir, based on the existence of chiadir.txt
FILE=./.chiadir.txt
if [ -f "$FILE" ]; then
    echo -e '\n'
else
    FINDDIR=$(find / -type d -name "chia-blockchain" 2>/dev/null | head -n1) && echo $FINDDIR > ./.chiadir.txt
    echo "Found Chia install directory in " $(cat ./.chiadir.txt) 
fi


cd $(cat ./.chiadir.txt)
. ./activate

SEEDERS=$(chia show -c | grep FULL_NODE | cut -d' ' -f2| wc -l)
NETSPACE=$(chia netspace | grep -i "Block Height" | tail -n1 | cut -d':' -f2)
NETESTIMATE=$(chia netspace | grep -i "network has an estimated" | cut -d' ' -f6-7)
SYNC=$(chia wallet show | grep -i sync)
LOOT=$(chia wallet show | grep -i "total balance" | head -n1 | awk '{print $3 " xch"}')
PLOTCOUNT=$(chia farm summary | grep -i 'Plot count' | awk '{print $3}')
TOTALPLOTS=$(chia farm summary | grep -i 'Total size' | awk '{print $5,$6}')

#############
#############

# check seeders
if [[ "$SEEDERS" -eq 0 ]]; then
    echo -e "=== Chia connections:" ' \t '  "\e[31m NO SEEDERS!!!\e[0m"
else
    echo -e "=== Chia connections:" ' \t '  "\e[32m $SEEDERS active connections\e[0m"
fi

# is wallet synced?
if [[ "$SYNC" == *"Synced"* ]]; then
    echo -e "=== Wallet synced?" ' \t '  "\e[32m Yes\e[0m"
else
    echo -e "=== Wallet synced?" ' \t '  "\e[31m NO!!!\e[0m"
fi

# Chia network stats
echo -e "=== Latest block:" ' \t '  "\e[96m$NETSPACE\e[0m"

#Chia net size
echo -e "=== Network size:" ' \t '  "\e[96m $NETESTIMATE\e[0m"

echo -e "\e[36m===========================\e[0m"

#farm summary
echo -e "=== Plot count:" '\t' "\e[96m  $PLOTCOUNT \e[0m"
echo -e "=== Total plots size:" '\t' "\e[96m  $TOTALPLOTS \e[0m"

#wallet balance
echo -e "=== Wallet ballance:" ' \t '  "\e[96m $LOOT\e[0m"
