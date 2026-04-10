FROM alpine:3.22.2   AS go_build

WORKDIR /opt/yozo/workdir

COPY ./tools/golang/gotpl.go .

RUN set -ex && \
    apk update && \
    apk add --no-cache tzdata  bash bash-doc bash-completion go upx && \
    go mod init gotpl.go  && \
    go build -o gotpl . && \
    upx -9 gotpl 

FROM ubuntu:noble-20260324

LABEL maintainer="Chtsen cyc@live.cn"

ARG TARGETARCH
ARG TOMCAT_V
ARG YOZO_JRE_V
ARG OPENJDK_V
ARG DCS_V

ENV DEBIAN_FRONTEND=noninteractive \
    OS_ARCH="${TARGETARCH:-amd64}" \
    TOMCAT_V="${TOMCAT_V:-9.0.115}" \
    YOZO_JRE_V="${YOZO_JRE_V:-1.8.0}" \
    DCS_V="${DCS_V:-4.17}" \
    TZ=Asia/Shanghai \
    APP_PORT=8060 \
    LANG=zh_CN.utf8 \
    LC_ALL=zh_CN.utf8 \
    SHUTDOWN_PORT=8005 

# 设置用户/组
RUN set -ex && \
    groupadd -g 1099 yozo && \
    useradd -m -g 1099 -u 1099 yozo && \
    apt-get update && \
    apt-get install sudo language-pack-zh-han* libxrender1 libxext6 libssl-dev curl openjdk-8-jdk -y && \
    apt-get clean && \
    echo "yozo ALL=(ALL)       NOPASSWD:ALL" >> /etc/sudoers && \
    curl -k -u temp:releases@2022 -SsLf -O "https://releases.yozosoft.com:4431/fcs/tools/jdk/YOZO_Jre_${OS_ARCH}_${YOZO_JRE_V}.tar.gz" -O "https://releases.yozosoft.com:4431/fcs/tools/tomcat/apache-tomcat-${TOMCAT_V}.tar.gz"  && \
    # curl -u temp:releases@2022 -SsLf -O "https://releases.yozosoft.com:4431/fcs/tools/jdk/YOZO_Jre_${OS_ARCH}_${YOZO_JRE_V}.tar.gz" -O "https://releases.yozosoft.com:4431/fcs/tools/jdk/OpenJDK8U-jdk_${OS_ARCH}_linux_hotspot_${OPENJDK_V}.tar.gz"  -O "https://releases.yozosoft.com:4431/fcs/tools/tomcat/apache-tomcat-${TOMCAT_V}.tar.gz"  && \
    mkdir -p /opt/yozo/yozo_office_jre/ /opt/yozo/fcscloud_tomcat /opt/yozo/cas/lic /opt/yozo/cas/conf /opt/yozo/cas/lib  /opt/yozo/data -p&& \
    tar -xf "YOZO_Jre_${OS_ARCH}_${YOZO_JRE_V}.tar.gz" -C /opt/yozo/yozo_office_jre/ --no-same-owner && \
    # tar -xf "OpenJDK8U-jdk_${OS_ARCH}_linux_hotspot_${OPENJDK_V}.tar.gz" -C /opt/yozo/open_jdk --strip-components=1 && \
    tar -xf "apache-tomcat-${TOMCAT_V}.tar.gz" -C /opt/yozo/fcscloud_tomcat --strip-components=1 && \
    # sed -i '125i\export JAVA_HOME=/opt/yozo/open_jdk' /opt/yozo/fcscloud_tomcat/bin/catalina.sh && \
    sed -i '26i\    <Resources cachingAllowed="true" cacheMaxSize="1000000" />' /opt/yozo/fcscloud_tomcat/conf/context.xml && \
    rm -rf *.tar.gz /opt/yozo/fcscloud_tomcat/webapps/* /var/lib/apt/lists/* && \
    chown -R 1099:1099 /opt/yozo && \
    chmod -R 755 /opt/yozo
    #echo "yozo ALL=(ALL)       NOPASSWD:/usr/bin/cat /sys/class/dmi/id/product_uuid,/bin/cat /sys/class/dmi/id/product_uuid" >> /etc/sudoers

COPY --chown=1099:1099 --chmod=755 ./tools/tpl/yozo-tomcat/server.xml.tpl /opt/yozo/fcscloud_tomcat/conf/
COPY --chown=1099:1099 --chmod=755 --from=go_build /opt/yozo/workdir/gotpl /opt/yozo/bin/
COPY --chown=1099:1099 --chmod=755 ./tools/shell/yozo-tomcat/${DCS_V}/entrypoint.sh /opt/yozo/bin/

CMD ["sh","-c","/opt/yozo/bin/entrypoint.sh"]
