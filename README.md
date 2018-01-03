# 集群服务器秘钥免登陆(测试版)
## 功能介绍
实现了目标主机在集群中需要进行的一些必要的批量操作。默认只开启了ssh免秘钥登陆.

测试版全部功能如下：
- ssh免秘钥登陆
- 安装部署saltstack的客户端，并指定master端ip地址
- 私钥分发，并修改私钥的权限为600

> 需要私钥群发，saltstack客户端安装功能的，请去掉相应功能的注释

## 注意事项
1. 安装saltstack客户端功能，master的ip地址需要修改nol_ssh.sh文件内的HOST_IP变量，或者开启13,14行注释来自动从指定网卡（默认为eth0）
2. 执行后，集群所有的服务器都有当前执行主机的公钥
3. 测试版本运行用户为root，否则可能无法运行
4. 需要将集群服务器的ip地址和密码（格式为：用户名[空格] 密码）写入当前目录的ip_passwd_example.txt文本文档内，可以在nol_ssh.sh文件内修改PASS_FILE变量来修改文件名
5. 确保你已经安装了expect
> centos用户使用yum -y install expect命令来安装expect


## 使用
将集群服务器的ip地址和密码（格式为：用户名[空格] 密码），写入ip_passwd_example.txt文本文档内，然后执行nol_ssh.sh脚本文件：
```
sh nol_ssh.sh
```
或
```
chmod +x nol_ssh.sh
./nol_ssh.sh
```
