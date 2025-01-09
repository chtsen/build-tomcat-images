#!/bin/bash

/opt/yozo/bin/gotpl /opt/yozo/fcscloud_tomcat/conf/server.xml.tpl
/opt/yozo/bin/gotpl /opt/yozo/fcscloud_tomcat/webapps/fcscloud/WEB-INF/classes/application.yml.tpl
/opt/yozo/bin/gotpl /opt/yozo/fcscloud_tomcat/webapps/fcscloud/WEB-INF/classes/config.properties.tpl
/opt/yozo/bin/gotpl /opt/yozo/fcscloud_tomcat/webapps/fcscloud/WEB-INF/classes/bootstrap.yml.tpl
/opt/yozo/bin/gotpl /opt/yozo/fcscloud_tomcat/webapps/fcscloud/WEB-INF/classes/convertConfig.properties.tpl

/opt/yozo/fcscloud/bin/catalina.sh run
