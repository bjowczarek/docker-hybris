#!/bin/bash

_catalina=/opt/hybris/config/tomcat/conf/catalina.properties
_line=$(awk '/tomcat.util.scan.StandardJarScanFilter.jarsToSkip/{ print NR; exit }' $_catalina)
_line=$(($_line + 1))
sed -i "${_line}i "'bcprov*.jar,\\' $_catalina

cd /opt/hybris/bin/platform/

. ./setantenv.sh

if [[ ! -z $ANT_TASKS ]]
then
  echo "Executing custom build tasks: $ANT_TASKS"
  ant $ANT_TASKS
else
  echo "Executing default build tasks: clean all"
  ant clean all
fi

./hybrisserver.sh
