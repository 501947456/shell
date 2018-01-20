#设置终端显示
echo -e "export PS1='[\u@192.168.8.145 \W]\\$ '"  >> /etc/profile
 ssh -i /root/.ssh/id_rsa -o StrictHostKeyChecking=no -o ConnectTimeout=30  192.168.1.x
