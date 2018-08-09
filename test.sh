#! /bin/bash

#初始配置
moni_Host=1
moni_User=1
moni_PW=1
moni_db=tech
moni_tb=monitor_info

les_Host=1
les_User=1
les_PW=1
les_db=cloudclass-dev
les_tb=lesson


today=$(date "+%Y-%m-%d %H:%M:%S")
echo '当前时间为'
echo $today
#获取当前时间的分钟数
m=$(date "+%M" -d " $today")
#得到余数
yushu_m=$(expr $m % 5)
echo '余数时间'
echo $yushu_m
#取得初始今天时间(抹掉5的倍数时间)比如10:01属于10:00 10:14属于10:10 10:17属于10:15等
init_time=$(date -d"$yushu_m minutes ago $today" +"%Y-%m-%d %H:%M:%S")
#real_m=$(expr $int_m \* 5);
echo '格式化之后的时间为：'
echo $init_time
#当前时间的五分钟后的时间
#five_time=$(date -d"5 minutes $init_time" +"%Y-%m-%d %H:%M:%S")
#echo $five_time

data=`mysql -h$les_Host -p$les_PW -u$les_User  -D$les_db -s <<EOF #指定Host，其他不变
SELECT count(*) FROM $les_tb WHERE actual_start_time<="$init_time" AND status=1;
COMMIT;
EOF`
echo '上课数----'
echo $data
insert=`mysql -h$moni_Host -p$moni_PW -u$moni_User  -D$moni_db <<EOF #指定Host，其他不变
INSERT INTO $moni_tb (id,event_time,event_num,event_type,time_add) VALUES ("","$init_time",$data,'on_class',"$init_time");
COMMIT;
EOF`
echo '执行成功'
#echo $les_db
#处理cloudclass_dev数据
#a=$(mysql -h$les_Host -p$les_PW -u$les_User  -D$les_db -s -e "SELECT count(*) FROM $les_tb")
