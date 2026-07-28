#!/bin/bash

/opt/yozo/bin/gotpl /opt/yozo/fcscloud_jar/config/application-prod.yml.tpl
java -jar /opt/yozo/fcscloud_jar/fcscloud.jar
