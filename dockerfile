FROM alpine:3.18.3   AS gotpl

WORKDIR /opt/yozo/

COPY gotpl.go .

RUN set -ex && \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
    apk update && \
    apk add --no-cache tzdata  bash bash-doc bash-completion go upx && \
    go mod init gotpl.go  && \
    go build -o gotpl . && \
    upx -9 gotpl 


FROM tomcat:9.0.89-jdk8-temurin-focal

LABEL maintainer="Chtsen cyc@yozosoft.com"

#COPY sources.list /etc/apt/sources.list
COPY server.xml.tpl /usr/local/tomcat/conf/
COPY --from=gotpl /opt/yozo/gotpl /opt/yozo/bin/ 

ARG TARGETARCH

ENV OS_ARCH="${TARGETARCH:-amd64}" \
    TZ=Asia/Shanghai \
    APP_PORT=8080 \
    LANG=zh_CN.utf8 \
    LC_ALL=zh_CN.utf8 \
    SHUTDOWN_PORT=8005 

# 设置用户/组
RUN set -ex && \
    sed -i 's@http://archive.ubuntu.com@https://mirrors.aliyun.com@g' /etc/apt/sources.list && \
    sed -i "s@http://ports.ubuntu.com@https://mirrors.aliyun.com@g" /etc/apt/sources.list && \
    groupadd -g 1099 yozo && \
    useradd -m -g 1099 -u 1099 yozo && \
    apt update && \
    apt install sudo language-pack-zh-han* -y && \
    echo "yozo ALL=(ALL)       NOPASSWD:ALL" >> /etc/sudoers && \
    curl -SsLf "https://repo.yozosoft.com/repository/oss/common/jdk/Jre_${OS_ARCH}_1.8.0.tar.gz" -O  && \
    mkdir -p /opt/yozo/yozo_office_jre/  && \
    tar -zxf "Jre_${OS_ARCH}_1.8.0.tar.gz" -C /opt/yozo/yozo_office_jre/ --no-same-owner && \
    rm -rf "Jre_${OS_ARCH}_1.8.0.tar.gz"
    #echo "yozo ALL=(ALL)       NOPASSWD:/usr/bin/cat /sys/class/dmi/id/product_uuid,/bin/cat /sys/class/dmi/id/product_uuid" >> /etc/sudoers

ENV TZ=Asia/Shanghai
