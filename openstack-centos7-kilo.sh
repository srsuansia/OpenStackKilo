#!/bin/sh

## Pre-requsite: Install Centos 7 minimal
## NOTE:
## Check the following before proceeding.
## 1> whether "ifconfig" command worning or not ?
## If not:
##      run the following command:
##      $   yum provides ifconfig
##      or
##      $   yum whatprovides ifconfig
##
##      $   yum install net-tools
##
## Testing:
##      $ ifonfig -a

echo "Stop NetworkManager ..."
systemctl stop NetworkManager
systemctl disable NetworkManager
systemctl status NetworkManager


echo "Configure yum repository .."
yum install http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm

echo "Configure OpenStack repository .."
yum install http://rdo.fedorapeople.org/openstack-kilo/rdo-release-kilo.rpm

echo "Configure NTP .."
yum -y install ntp
ntpdate -u 0.centos.pool.ntp.org
systemctl enable ntpd
systemctl start ntpd
systemctl status ntpd

echo "Install openvswitch .."
yum -y install openvswitch

echo "Configure openswitch .."
systemctl enable openvswitch.service
systemctl start openvswitch.service

echo "Create openvswitch bridge .."
ovs-vsctl add-br br-int
ovs-vsctl add-br br-ex

echo "Verifying bridge creation .."
ovs-vsctl show



        