# alpine-turn-docker
基于alpine系统制作turn镜像，体积小，只需要42.9M，其他镜像动则200M起步

## 修改变量配置
#### dockerfile中的变量
#### ENV TURN_USERNAME 用户名
#### ENV TURN_PASSWORD 密码
#### ENV REALM 域名

## 执行脚本
docker run --init -d --restart always -p 3478:3478 -p 3478:3478/udp --name=turn turn
