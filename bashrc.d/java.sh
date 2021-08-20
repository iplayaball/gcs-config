#!/bin/bash
##########################################################################
# Author: wangdj
# mail: wangdajunzy@163.com
# Created Time: Fri 20 Aug 2021 02:08:32 PM CST
##########################################################################

#set oracle jdk environment
export JAVA_HOME=~/tools/jdk1.8.0_201
export JRE_HOME=${JAVA_HOME}/jre 
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib 
export PATH=${JAVA_HOME}/bin:$PATH

#set maven environment
export M2_HOME=~/tools/apache-maven-3.6.3
export PATH=${M2_HOME}/bin:$PATH

