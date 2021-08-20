#!/bin/bash
##########################################################################
# Author: wangdj
# mail: wangdajunzy@163.com
# Created Time: Fri 20 Aug 2021 12:37:07 PM CST
##########################################################################

#thisDir=$(cd $(dirname $0) && pwd )
gcsCfg=~/.gcs-config
bashrcd=$gcsCfg/bashrc.d
export PATH=$PATH:$gcsCfg/bin

if [ -d $bashrcd ]; then
  for i in $bashrcd/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi

