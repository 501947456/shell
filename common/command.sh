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


