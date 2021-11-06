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

home=`pwd`
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# root home change to user home
sed -i "s#root:/root#root:$home#g" /etc/passwd
# 配置 gcsh 启动时运行的命令
if ! [ -f .customize_environment ]; then
cat > .customize_environment << EOF
#!/bin/bash

# config time zone
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# root home change to user home
sed -i "s#root:/root#root:$home#g" /etc/passwd

#解决ipython3 报错
# pip3 install -U jedi==0.17.2 parso==0.7.1
# apt-get install -y tree expect ifstat

EOF
fi

# 配置 ssh 登录时运行的 bash 环境配置
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

configRclone() {
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


# config vim
cp -av $gcsCfg/vimrc-min .vimrc

#apt-get install -y dos2unix expect screen rsync

#echo 'deflog on' >> /etc/screenrc
#echo "logfile $home/logsc/screen-%S_%Y-%m-%d-%c.log" >> /etc/screenrc
#EOF


# install gclone as rclone
if ! [ -f .gems/bin/rclone ]; then
  wget https://github.com/donwa/gclone/releases/download/v1.51.0-mod1.3.1/gclone_1.51.0-mod1.3.1_Linux_x86_64.gz
  gunzip gclone_1.51.0-mod1.3.1_Linux_x86_64.gz
  mkdir -p .gems/bin
  mv -v gclone_1.51.0-mod1.3.1_Linux_x86_64 .gems/bin/rclone
  chmod +x .gems/bin/rclone
else
  echored "rclone already install in .gems/bin/rclone" 
fi

# config gclone as rclone
if [ -f $gcsCfg/rclone.conf ]; then
  mkdir -p .config/rclone/
  cp -av $gcsCfg/rclone.conf .config/rclone/
else
  echored "no gclone.conf file"
fi


#install rar
#wget https://www.rarlab.com/rar/rarlinux-x64-5.9.1.tar.gz
