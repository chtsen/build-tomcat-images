#!/bin/bash

/opt/yozo/bin/gotpl /opt/yozo/fcscloud_jar/config/application-prod.yml.tpl
java ${JAVA_OPTS} -jar fcscloud.jar
