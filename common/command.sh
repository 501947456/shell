#设置终端显示
echo -e "export PS1='[\u@192.168.8.145 \W]\\$ '"  >> /etc/profile
 ssh -i /root/.ssh/id_rsa -o StrictHostKeyChecking=no -o ConnectTimeout=30  192.168.1.x


#禁用密码登录
sed -i "s#PasswordAuthentication yes#PasswordAuthentication no#g"  /etc/ssh/sshd_config
sed -i "s#GSSAPIAuthentication yes#GSSAPIAuthentication no#g"  /etc/ssh/sshd_config
sed -i "s@#UseDNS yes@UseDNS no@" /etc/ssh/sshd_config
sed -i 's/.*LogLevel.*/LogLevel DEBUG/g' /etc/ssh/sshd_config
sed -i 's@#MaxStartups 10@MaxStartups 50@g' /etc/ssh/sshd_config
systemctl reload sshd


shell获取某个时间段的nginx日志内容
cat web.log | egrep "01/Apr/2014" | sed  -n '/21:31:36/,/21:50:08/p'  


mkdir -p  ~/.pip
cat <<EOF > ~/.pip/pip.conf
[global]
index-url = http://mirrors.aliyun.com/pypi/simple/

[install]
trusted-host=mirrors.aliyun.com
EOF


#sshkey_deploy
#!/usr/bin/expect     
set timeout 30
set hostip [lindex $argv 0]
set password [lindex $argv 1]
spawn ssh-copy-id -i /root/.ssh/id_rsa.pub root@$hostip
expect "*assword:"
send "$password\n"
expect eof

运行方式
expect  sshkey_deploy 192.168.1.186 xxxx

