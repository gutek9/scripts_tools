#!/bin/bash

if [ "$EUID" -ne 0 ]
        then echo "Please run as root or using sudo"
        exit -1
fi

IP=$1
NETMASK="255.255.252.0"
IFACES_FILE="/etc/network/interfaces"
LAST_IFACE=$(cat $IFACES_FILE | grep "auto eth0:" | cut -d ":" -f2 | sort -nr | head -1)
NEXT_IFACE=$((LAST_IFACE+1))

echo "Adding $IP..."

echo -e "\nauto eth0:$NEXT_IFACE\niface eth0:$NEXT_IFACE inet static\n\taddress $IP\n\tnetmask $NETMASK" >> $IFACES_FILE

ifup eth0:$NEXT_IFACE

echo "Done."
