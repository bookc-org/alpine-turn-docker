# alpine-turn-docker
基于alpine系统制作turn镜像，体积小，只需要42.9M，其他镜像动则200M起步

## 修改变量配置
#### dockerfile中的变量
#### ENV TURN_USERNAME 用户名
#### ENV TURN_PASSWORD 密码
#### ENV REALM 域名

## 执行脚本
docker run --init -d --restart always -p 3478:3478 -p 3478:3478/udp --name=turn turn

## 注意事项
turnserver.sh 文件中的这行命令是找到当前服务的本地ip,找到的可能是一个列表，需要过滤掉一些IP，grep -v -e 过滤多个IP
PRIVATE_IP=$(ifconfig | awk '/inet addr/{print substr($2,6)}' | grep -v -e 127.0.0.1 -e 127.0.0.1 -e 172.18.0.1 -e 172.17.0.1)
