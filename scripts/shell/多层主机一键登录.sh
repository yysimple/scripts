#!/usr/bin/expect

# 设置超时时间
set timeout -1
# 跳板机的账号密码端口等信息
set PORT xxx
set HOST xxx
set USER xxx
set PASSWORD xxx
set REAL_MACHINE xxx

# 登录跳板机
spawn ssh -p $PORT $USER@$HOST
expect {
        "yes/no" {send "yes\r";exp_continue;}
         "*password:*" { send "$PASSWORD\r" }
        }
# 匹配到有"Publish"的文案，然后 jj 下健按两次 \r 回车
expect {
  -re "Publish" {
    send "jj\r"
    }
  }
sleep 1

# 登录机器
expect "$*" {
    send "ssh $REAL_MACHINE\r"
}

# 打印日志
expect "$*" {
    send "tail -100f logs/schedule-center/log-info.log\r"
    interact
}