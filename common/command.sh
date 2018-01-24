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
