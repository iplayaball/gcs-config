#!/bin/bash
##########################################################################
# Author: wangdj
# mail: wangdajunzy@163.com
# Created Time: Fri 20 Aug 2021 02:11:40 PM CST
##########################################################################

#history
export HISTFILE=~/.history
export HISTTIMEFORMAT="%F %T "
export HISTFILESIZE=1000000
export HISTSIZE=1000
#USER_IP=`who -u am i 2>/dev/null| awk '{print $NF}'|sed -e 's/[()]//g'`
export HISTCONTROL=ignoreboth # ignorespace ignoredups
# export PROMPT_COMMAND="history -a; history -r;  $PROMPT_COMMAND"
# 实时的记录入文件
export PROMPT_COMMAND="history -a"
# 这条配置，就可以使一个终端的用户监控到另一个终端用户输入的命令内容
shopt -s histappend
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

