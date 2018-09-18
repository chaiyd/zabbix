#!/bin/bash
#######################################################
# $Name:         zabbix_agentd_install.sh
# $Author:       chaiyd
# $Email:        chaiyd.cn@gmail.com
# $Create Date:  2018-09-11
#######################################################


insdir=/mnt/zabbix-agent   #安装目录
sourcedir=$PWD
sname=zabbix-3.2.4
sourcename=${sname}.tar.gz

echo -e "********************dir********************"
echo -e "\033[32;49;1m insdir:\t$insdir \033[39;49;0m"
echo -e "\033[32;49;1m sourcedir:\t$sourcedir \033[39;49;0m"
echo -e "******************************************\n"
Gcc_len=`rpm -qa gcc| wc -l`
    if [[ $Gcc_len -eq 0 ]];then
		echo -e "\033[31m${sname} gcc没有安装，正在安装gcc \033[0m "
		yum install gcc -y 1>/dev/null
	fi
cd $sourcedir && tar xf zabbix-3.2.4.tar.gz && cd zabbix-3.2.4
	echo -e "\033[32;49;1mmake zabbix ......\033[39;49;0m" 
	./configure --prefix=$insdir --enable-agent 1>/dev/null && make install 1>/dev/null
	    if [[ $? != 0 ]];then
			echo -e "\033[31m${sname} make ERROR,please make again\033[0m "
			exit
		fi

cd $insdir && mkdir logs
        if [[ $? != 0 ]];then
			echo -e "\033[31m${sname} 创建logs目录失败\033[0m "
			
		fi
		
echo -e "\033[32;49;1m 安装目录添加权限 \033[39;49;0m"
echo -e "******************************************\n"	
chown -R zabbix:zabbix $insdir 1>/dev/null		 
        if [[ $? != 0 ]];then
		       groupadd zabbix
           useradd -g zabbix -s /sbin/nologin  -M zabbix
           chown -R zabbix:zabbix $insdir 1>/dev/null
	    	fi
		
echo -e "\033[32;49;1m 替换配置文件 \033[39;49;0m"		
sed -i '30s@tmp@mnt/zabbix-agent/logs@g'  /mnt/zabbix-agent/etc/zabbix_agentd.conf
sed -i '91s/127.0.0.1/192.168.30.5/g'  /mnt/zabbix-agent/etc/zabbix_agentd.conf  
sed -i '132s/ServerActive=127.0.0.1/ /g'  /mnt/zabbix-agent/etc/zabbix_agentd.conf
sed -i '143s/Zabbix server/zabbix_agentd/g'  /mnt/zabbix-agent/etc/zabbix_agentd.conf
#sed -i '132s/ServerActive=127.0.0.1/ServerActive=192.168.30.5/g'  /mnt/zabbix-agent/etc/zabbix_agentd.conf
#sed -i '143s/#HostnameItem=system.hostname/HostnameItem=system.hostname/g'  /mnt/zabbix-agent/etc/zabbix_agentd.conf
#sed -i '143s/Hostname=Zabbix server/#Hostname=Zabbix server/g'  /mnt/zabbix-agent/etc/zabbix_agentd.conf


echo -e "\033[32;49;1m 添加开机启动 \033[39;49;0m"
cp $sourcedir/$sname/misc/init.d/tru64/zabbix_agentd /etc/init.d/
sed -i '2i #chkconfig: 2345 10 90' /etc/init.d/zabbix_agentd
sed -i '3i #description: zabbix_agentd' /etc/init.d/zabbix_agentd
sed -i '26s@usr/local@mnt/zabbix-agent@g' /etc/init.d/zabbix_agentd
sed -i '27s@tmp@mnt/zabbix-agent@g' /etc/init.d/zabbix_agentd
chmod +x /etc/init.d/zabbix_agentd
chkconfig --add zabbix_agentd
#/etc/init.d/zabbix_agentd start
