#!/bin/bash
##########################################################################
# Author: wangdj
# mail: wangdajunzy@163.com
# Created Time: Sat 07 Aug 2021 03:38:16 PM CST
##########################################################################

echored(){
  echo -e "\e[31m$*\e[0m"
}

if ! echo $(pwd) |grep -q '^/home/'; then
  echored 'not home'
  exit
fi

# thisDir=$(cd $(dirname $0) && pwd )
bashrc=~/.bashrc
gcsCfg=.gcs-config

if ! grep -q $gcsCfg $bashrc; then
  echo '". ~/$gcsCfg/main_rc.sh" >> ~/.bashrc'
  echo ". ~/$gcsCfg/main_rc.sh" >> ~/.bashrc
fi

# git
git config --global core.editor vim
git config --global user.name "gcs-${HOME##*/}"
git config --global user.email "wangdajunzy@163.com"

args="rclone"
if [ -n "$1" ]; then
  for arg in "$@"; do
    # 如果脚本的参数不在定义的 args 变量列表中，则退出脚本
    if ! echo "$args" | grep -wq "$arg"; then
      echo $arg is wrong
      echo 'args': $args
      exit
    fi
  done
fi

configRclone()
{
# config sa
l="marvel-2500SA-marveltdste@985211.ml.zip\
   marvel-800SA-mirrorone@googlegroups.com.zip\
   wdjddf-1400SA-ttf0815@googlegroups.com.zip\
   yinni-900SA-dxzdxz@googlegroups.com.zip"

rclone=".gems/bin/rclone --config .config/rclone/rclone.conf"
for i in $l; do
  echored $i
  $rclone sync -v gd:_af/$i .
  unzip $i >/dev/null || echored "unzip $i fail"
  rm -fv $i
done
}

if [[ $1 == rclone ]]; then
  echored configRclone
  configRclone
fi


exit


# config vim
cp -av $gcsinitpath/vimrc-min .vimrc

cat > .customize_environment << EOF
#!/bin/bash

# config time zone
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# root home change to user home
sed -i "s#root:/root#root:$home#g" /etc/passwd

#解决ipython3 报错
# pip3 install -U jedi==0.17.2 parso==0.7.1

EOF

#apt-get install -y dos2unix expect screen rsync

#echo 'deflog on' >> /etc/screenrc
#echo "logfile $home/logsc/screen-%S_%Y-%m-%d-%c.log" >> /etc/screenrc
#EOF


# install gclone as rclone
if ! [ -f gopath/bin/rclone ]; then
  wget https://github.com/donwa/gclone/releases/download/v1.51.0-mod1.3.1/gclone_1.51.0-mod1.3.1_Linux_x86_64.gz
  gunzip gclone_1.51.0-mod1.3.1_Linux_x86_64.gz
  mkdir -p gopath/bin
  mv -v gclone_1.51.0-mod1.3.1_Linux_x86_64 gopath/bin/rclone
  chmod +x gopath/bin/rclone
else
  echored "rclone already install in gopath/bin/rclone" 
fi

# config gclone as rclone
if [ -f $gcsinitpath/rclone.conf ]; then
  mkdir -p .config/rclone/
  cp -av $gcsinitpath/rclone.conf .config/rclone/
else
  echored "no gclone.conf file"
fi


#install rar
#wget https://www.rarlab.com/rar/rarlinux-x64-5.9.1.tar.gz
