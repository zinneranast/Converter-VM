#!/bin/bash

vlanId=$1

ip link add link eth0 name eth0.$vlanId type vlan id $vlanId
ip link set dev eth0.$vlanId up

ip link add vxlan$vlanId type vxlan id $vlanId group 239.0.0.1 port 0 0 ttl 4 dev eth1
ip link set dev vxlan$vlanId up

brctl addbr bridge$vlanId
ip link set dev bridge$vlanId up
brctl addif bridge$vlanId eth0.$vlanId
brctl addif bridge$vlanId vxlan$vlanId
