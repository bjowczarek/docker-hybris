#!/bin/bash
echo "Setting Ant na Java JVM params.."
export ANT_OPTS="-Xmx6144m -XX:MaxPermSize=1536m -Dfile.encoding=UTF-8"
export JAVA_OPTIONS='-Xmx6144m'