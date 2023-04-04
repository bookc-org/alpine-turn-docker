FROM alpine:latest

#指定阿里镜象
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

#设置时区
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone

#增加字体，解决验证码没有字体报空指针问题
RUN set -xe && apk --no-cache add ttf-dejavu fontconfig

#安装curl
RUN apk add --no-cache curl

#安装bash
RUN apk add --no-cache --upgrade bash

RUN apk update && apk add coturn

WORKDIR /opt/turn

COPY ./turnserver.sh /opt/turn/turnserver.sh

#RUN chmod 777 /opt/turn/turnserver.sh

ENV TURN_USERNAME turn
ENV TURN_PASSWORD turn
ENV REALM turn.bookc.com

EXPOSE 3478 3478/udp

ENTRYPOINT ["/opt/turn/turnserver.sh"]
