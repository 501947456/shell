#设置终端显示
echo -e "export PS1='[\u@192.168.8.145 \W]\\$ '"  >> /etc/profile
 ssh -i /root/.ssh/id_rsa -o StrictHostKeyChecking=no -o ConnectTimeout=30  192.168.1.x
 ssh -o StrictHostKeyChecking=no -p 22 $remote_ip "mkdir -p /data/cross/;chmod -R 777 /data/cross/"


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


#######AWK Nginx################
统计IP访问次数
awk '{a[$NF]++}END{for(i in a) print a[i],i}' b09tcusk8qcy.access.log.2018-10-29

#统计访问次数大于100次的IP

awk '{a[$NF]++}END{for (i in a){if(a[i]>=100)print i,a[i]}}' b09tcusk8qcy.access.log.2018-10-29 

#统计访问IP次数并排序前10
awk '{a[$NF]++}END{for(i in a)print i,a[i] |"sort -k2 -nr|head -10"}' b09tcusk8qcy.access.log.2018-10-29 

#统计时间段访问次数最多的IP
awk '$4>="[29/Oct/2018:05:16:05" && $4<="[29/Oct/2018:21:16:05"{a[$NF]++}END{for(v in a)print v,a[v]}' b09tcusk8qcy.access.log.2018-10-29


#统计上一分钟访问量

date=$(date -d '-1 minute' +%d%d%Y:%H:%M)
awk -vdate=$date '{$4~date{c++}END{print c}}' access.log

#统计访问最多的十个页面
awk '{a[$7]++}END{for(v in a)print v,a[v] |"sort -k1 -nr |head -n10"}'  access.log

#统计每个URL数量和返回内容总大小
awk '{a[$7]++;size[$7]+=$10}END{for(v in a)print a[v],v,size[v]}' access.log
#统计访问IP是404状态次数

awk '{if($9~/404/)a[$1" "$9]++}END{for(i in a)print v,a[v]}' access.log

awk '/aa/{print $0" YES";next}{print $0" YES NO"}' file 

 awk '/aa/{print $0" YES"}!/aa/{print $0" YES NO"}' file
 
 cat file | awk '/^Pack.*Hello.*/{a=1}/^Owner/&&a{b=$0}END{if(b)print b}1'

＃数组去重
cat file | awk 'BEGIN{FS=OFS="|"}a[$2]++{$2=""}1'
＃字符串拼接
awk file '!/lib/{a=$0" "a}/lib/{print $0,a;a=""}'

awk file '!/lib/{a=$0" "a;next}/lib/{$0=$0" "a;a=" "}1'

#循环
echo "axb{sfxcxe}dxe{dfefx2xfxf}sdxfdfd" | awk 'BEGIN{OFS=FS=""}{for(i=0;i<NF;i++){if($i=="{"){a=1}if($i=="}"){a=0}if(a&&$i=="x"){$i=";"}}}1'


sed 格式化输出df -h
df -h|sed '1d;/ /!N;s/\n//;s/ \+/ /;'

1d——————删除第一行
/ /!N——————没有空格的行执行N
例子中没有空格的行
/dev/mapper/vg_dsidealyy-lv_root/dev/mapper/vg_dsidealyy-lv_home
s/\n//——————pattern空间内的换行替换为空格
s/ \+/ /——————N多空格替换为一个空格

####修改主机名
ifconfig | grep "inet addr" |egrep -v "127|172" |awk '{print $2}' | awk -F"addr:" '{print $2}' |awk -F'.' '{print "web""-"$1"-"$2"-"$3"-"$4"-admin.com"}'

方式一：创建子shell,在子shell中运行ssh-agent,退出子shell 自动结束代理
ssh-agent $SHELL

方式二： 单独启动一个代理进程，退出当前shell时最好使用ssh-agent -k 关闭对应代理
eval `ssh-agent`

关闭ssh-agent 
ssh-agent -k pid

将私钥添加到ssh代理
ssh-add ~/.ssh/key_name

查看代理中的私钥
ssh-add -l

查看代理中的私钥对应的公钥
ssh-add -L

移除指定的私钥
ssh-add -d /path/key_name

移除代理中的所有私钥
ssh-add -D
 
#echo 文字显示颜色
echo -e "\033[1;31m 无法连接${test_ip}，脚本退出 \033[0m"
echo -e "\033[1;32m ${test_ip}连接成功 \033[0m "

#shell交互

function verify {
while true;do
read -p "是否确认?[y/n]" ACK
case $ACK in
        y|Y|yes|YES) 
                break
                ;;
          n|N|no|NO)
                exit
                ;;
                  *)
                echo "Please Enter y/yes/Y/YES or n/no/N/NO."
                ;;
esac
done
}

#rsync
	rsync -avz --delete --exclude='.svn/' -e "ssh -o StrictHostKeyChecking=no -o ConnectTimeout=60"  /data/cross/$sid $remote_ip:/data/cross/
	num=`rsync -avn --delete --exclude='.svn/' -e "ssh -o StrictHostKeyChecking=no -o ConnectTimeout=60" /data/hefu/${Sid}/* $remote_ip:/root/hefu/$Sid/table/|grep -v ^sending|grep -v ^sent|grep -v ^total|grep -v ^$|grep -v "^./$"`


#tee 追加记录日志
bak_log $@ |tee -a /root/hefu/log/$today/bak/${2}_bak_scp2.log


#case

function check_hefu {
case $role_game in
 "shushan")
	echo -e "=============================================================="
	echo -e "当前分配阵营:  \\033[20G 蜀山 \033[0m"
	echo -e "当前区服主库IP:  \\033[20G ${db1_ser_innerip}\033[0m"
	echo -e "当前区服标记:  \\033[20G ${ser_flag}\033[0m"
	echo -e "=============================================================="
 	
 ;;
 "penglai")
	echo -e "=============================================================="
	echo -e "当前分配阵营:  \\033[20G 蓬莱 \033[0m"
	echo -e "当前区服主库IP:  \\033[20G ${db1_ser_innerip}\033[0m"
	echo -e "当前区服标记:  \\033[20G ${ser_flag}\033[0m"
	echo -e "=============================================================="
 	
 ;;
 "kunlun")
 	echo -e "=============================================================="
	echo -e "当前分配阵营:  \\033[20G 昆仑 \033[0m"
	echo -e "当前区服主库IP:  \\033[20G ${db1_ser_innerip}\033[0m"
	echo -e "当前区服标记:  \\033[20G ${ser_flag}\033[0m"
	echo -e "=============================================================="
 	
 ;;
 *)
 	echo "Usage:sh `basename $0` [合服服务器IP] [ser_id] [shushan|penglai|kunlun] [1|2]"
 	echo -e "Example:sh `basename $0` 119.145.254.106 andrHF1_S13 1 \n"
 	exit 1
 ;;
esac

}


#for 循环

for remote_ip in {$op_center,$center,$touxiang_IP,$cross_IP}
do
ssh=`ssh -o stricthostkeychecking=no ${remote_ip} "ls /"`
if [[ -z "${ssh}" ]];then
	echo -e "\033[1;31m 无法连接${remote_ip}，脚本退出 \033[0m"
	exit 1
else
	echo -e "\033[1;32m ${remote_ip}连接成功 \033[0m "
fi
done









