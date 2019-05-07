awk -v OFS='+++' '{print $1,$2}' test1
awk '{print $1 $2}'  表示每行分割后，将第一列（第一个字段）和第二个列（第二个字段）连接在一起输出
awk '{print $1 $2}'  表示每行分割后，将第一列（第一个字段）和第二个列（第二个字段）以输出分隔符输出

FS ：输入字段分隔符，默认为空白字符
OFS：输出字段分隔符，默认为空白字符
RS：输入记录分隔符（输入换行符），指定输入时的换行符
ORS：输出记录分隔符（输出换行符），输出时用指定符号替换换行符
NF：当前行的字段的个数（即当前行被分割成了几列）字段数量
NR： 行号，当前处理的文本行的行号
FNR： 各文件分别计数的行号
FILENAME：当前文件名
ARGC： 命令行参数的个数
ARGV：数组，保存的命令行所给定的各参数

awk 'BEGIN{print "aaa",ARGV[0],ARGV[1],ARGV[2]}' test1 test2
   aaa awk test1 test2
   
awk 'BEGIN{print "aaa",ARGV[0],ARGV[1],ARGV[2],ARGC}' test1 test2
   aaa awk test1 test2 3
   
awk 'BEGIN{myVar1="111";myVar2="222";print myVar1,myVar2}'
111 222

iexbuy@iexbuy-System-Product-Name:~$ abc=666
iexbuy@iexbuy-System-Product-Name:~$ awk -v myvar=$abc 'BEGIN{print myvar}'


iexbuy@iexbuy-System-Product-Name:~$ printf "%s\n" abc def ghi jkl mon
abc
def
ghi
jkl
mon

printf "%s %s %s\n"  姓名 性别 年龄 尼玛 男 20 你妹 女 18 
姓名 性别 年龄
尼玛 男 20
你妹 女 18

iexbuy@iexbuy-System-Product-Name:~$ printf "%7s %5s %4s\n"  姓名 性别 年龄 尼玛 男 20 你妹 女  8 
 姓名 性别 年龄
 尼玛   男   20
 你妹   女   18
 
#左对齐
iexbuy@iexbuy-System-Product-Name:~$ printf "%-7s %-5s %-4s\n"  姓名 性别 年龄 尼玛 男 20  你妹   18 
姓名  性别 年龄
尼玛  男   20  
你妹  女   18 

awk -v FS=":" 'BEGIN{printf "%-10s\t %s\n","用户名","用户ID"} {printf "%-10s\t %s\n",$1,$3}' /etc/passwd

awk '/\/bin\/bash$/{print $0}' /etc/passwd

#使用扩展正则表达式
awk --posfix '/he{2,3}y/{print $0}' test3


从Lee第一次出现的行，到Kevin第一次出现的行之间的所有行
awk '/Lee/,/Kevin/{print $0}' test4

awk 'NR>=3 && NR<=6 {print $0}' test4
