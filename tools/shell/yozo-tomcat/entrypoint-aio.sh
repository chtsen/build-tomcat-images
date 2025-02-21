#!/bin/bash

/opt/yozo/bin/gotpl /opt/yozo/fcscloud_tomcat/conf/server.xml.tpl
/opt/yozo/bin/gotpl /opt/yozo/fcscloud_tomcat/webapps/fcscloud/WEB-INF/classes/application.yml.tpl
/opt/yozo/bin/gotpl /opt/yozo/fcscloud_tomcat/webapps/fcscloud/WEB-INF/classes/config.properties.tpl
/opt/yozo/bin/gotpl /opt/yozo/fcscloud_tomcat/webapps/fcscloud/WEB-INF/classes/bootstrap.yml.tpl
/opt/yozo/bin/gotpl /opt/yozo/fcscloud_tomcat/webapps/fcscloud/WEB-INF/classes/convertConfig.properties.tpl
# 需要检查创建的目录列表
directories=( "/opt/yozo/data/redis" "/opt/yozo/data/logs/redis" )
 
# 循环检查并创建每个目录
for dir in "${directories[@]}"; do
  if [ ! -d "$dir" ]; then
    mkdir -p "$dir"
    echo "Directory $dir created."
  else
    echo "Directory $dir already exists."
  fi
done

/usr/bin/redis-server /opt/yozo/conf/redis/redis.conf 
/opt/yozo/fcscloud_tomcat/bin/catalina.sh run
