#!/bin/bash
##########################################################################
# Author: wangdj
# mail: wangdajunzy@163.com
# Created Time: Fri 20 Aug 2021 02:31:07 PM CST
##########################################################################
set -e

commitMsg="$*"

git add .
git commit -m "$commitMsg" 
git push

