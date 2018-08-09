#clear
Host=6
User=cloudclass
PW=6
DB=tech
TN=monitor_info
#远程连接
#SELECT * FROM $TN;

time1=$(date +%s -d'2018-08-08 00:00:00')
#echo $time1
function rand(){
	min=$1
	max=$(($2-$min+1))
	num=$(date +%s%N)
	echo $(($num%$max+$min))
	}
#rand=$(rand 1 100)#随机100以内的数
#echo $rand
#exit 0 退出
for((i=1;i<=288;i++));
do
#echo $time1
time1=`expr $time1 + 300`
time2=$(date +%Y-%m-%d\ %H:%M:%S -d "1970-01-01 UTC $time1 seconds")
echo $time2
rand=$(rand 1 100)
mysql -h$Host -u$User -p$PW <<EOF
use $DB;

INSERT INTO $TN (id,event_time,event_num,event_type,time_add) VALUES ('',"$time2","$rand",'on_class',"$time2");

COMMIT;
EOF

done;
