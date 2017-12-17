#!/bin/bash
##Author: Chenjie########################
##gitLab: https://gitlab.com/chuxuan909##
#免秘钥登陆脚本########################
##########变量说明#####################
###变量PASS_FILE为IP-密码文件名称####
###此文件和脚本必须在同一个目录下###
PASS_FILE=ip_passwd_example.txt
USER_N=root
USER_HOME=/root
###安装saltstack的master服务端ip地址#
HOST_IP=10.27.95.184
#USE_IFCONFIG=eth0
#HOST_IP=$(ifconfig $USE_IFCONFIG | grep "inet addr" | awk '{ print $2}' | awk -F: '{print $2}')
########检验是否生成秘钥对############
[ ! $(ls /root/.ssh|grep id_rsa*|wc -l) -ne 0 ] && echo -e "\e[0;31mPlease generate the key pair: use the command ssh-keygen-t rsa\e[0m" && exit 9
########使用密码文件的信息传递公钥##
[ ! -f $PASS_FILE ] && echo -e "\e[0;31mPass File Is Not Exsit ...\n You need a password file to record the ip address and login password (Example:\e[0m ip_passwd_example.txt)\e[0;31mto add to the host\e[0m" && exit 8
for i in $(awk '{print $1}' $PASS_FILE)
do
j=$(awk -v I="$i" '{if(I=$i)  print $2}'  $PASS_FILE)
expect nol_ssh.exp $i  $j
#########传递私钥到集群主机#################
#scp /root/.ssh/id_rsa root@$i:/root/.ssh/
##修改私钥为600权限的脚本##################
#expect nol_ssh_prv.exp $i 
############################################
#########在集群服务器上安装saltstack客户端#
#expect nol_ssh_fun.exp $i $HOST_IP
############################################
done
