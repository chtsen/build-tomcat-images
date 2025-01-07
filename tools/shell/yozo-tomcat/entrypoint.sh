#!/bin/bash

/opt/yozo/bin/gotpl /opt/yozo/fcscloud/conf/server.xml.tpl
/opt/yozo/bin/gotpl /opt/yozo/fcscloud/webapps/fcscloud/WEB-INF/classes/application.yml.tpl
/opt/yozo/bin/gotpl /opt/yozo/fcscloud/webapps/fcscloud/WEB-INF/classes/config.properties.tpl
/opt/yozo/bin/gotpl /opt/yozo/fcscloud/webapps/fcscloud/WEB-INF/classes/bootstrap.yml.tpl
/opt/yozo/bin/gotpl /opt/yozo/fcscloud/webapps/fcscloud/WEB-INF/classes/convertConfig.properties.tpl

/opt/yozo/fcscloud/bin/catalina.sh run
