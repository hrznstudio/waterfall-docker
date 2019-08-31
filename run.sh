#!/bin/bash
set -e

sed -i "s/{{motd}}/\&1${HOSTNAME}/" /waterfall/config.yml

COMMAND="java -Xmx$JAVA_MEMORY -Xms$JAVA_MEMORY $JAVA_ARGS -jar SubServers.Patched.jar"
echo "Running Waterfall - $COMMAND"

cd /waterfall
eval $COMMAND
