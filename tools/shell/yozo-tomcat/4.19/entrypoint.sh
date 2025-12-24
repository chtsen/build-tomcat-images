#!/bin/bash

/opt/yozo/bin/gotpl /opt/yozo/fcscloud_tomcat/conf/server.xml.tpl
/opt/yozo/bin/gotpl /opt/yozo/fcscloud_tomcat/webapps/fcscloud/WEB-INF/classes/application-prod.yml.tpl

/opt/yozo/fcscloud_tomcat/bin/catalina.sh run
