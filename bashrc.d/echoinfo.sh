#!/bin/bash
##########################################################################
# Author: wangdj
# mail: wangdajunzy@163.com
# Created Time: Fri 20 Aug 2021 01:56:59 PM CST
##########################################################################

uptime
curl ipinfo.io &>/tmp/ipinfo
country=`grep country /tmp/ipinfo |awk -F'"' '{print$4}'`
use=`df -Th |grep /home |egrep -ow "[0-9]+%"`
echo "${HOME##*/} $country $use"

