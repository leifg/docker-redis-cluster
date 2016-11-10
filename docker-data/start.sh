IP=`ifconfig | grep "inet addr:17" | cut -f2 -d ":" | cut -f1 -d " "`

/redis/src/redis-server /redis-conf/7000/redis.conf &
/redis/src/redis-server /redis-conf/7001/redis.conf &
/redis/src/redis-server /redis-conf/7002/redis.conf &
/redis/src/redis-server /redis-conf/7003/redis.conf &
/redis/src/redis-server /redis-conf/7004/redis.conf &
/redis/src/redis-server /redis-conf/7005/redis.conf &
/redis/src/redis-server /redis-conf/7006/redis.conf &
/redis/src/redis-server /redis-conf/7007/redis.conf &

bash /wait-for-it.sh $IP:7000
bash /wait-for-it.sh $IP:7001
bash /wait-for-it.sh $IP:7002
bash /wait-for-it.sh $IP:7003
bash /wait-for-it.sh $IP:7004
bash /wait-for-it.sh $IP:7005
bash /wait-for-it.sh $IP:7006
bash /wait-for-it.sh $IP:7007

echo "yes" | ruby /redis/src/redis-trib.rb create --replicas 1 ${IP}:7000 ${IP}:7001 ${IP}:7002 ${IP}:7003 ${IP}:7004 ${IP}:7005

tail -f /var/log/redis*.log
