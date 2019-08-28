#!/bin/bash
set -e

sed -i "s/{{MOTD}}/&1${HOSTNAME}/" /waterfall/config.yml

COMMAND="java -Xmx$JAVA_MEMORY -Xms$JAVA_MEMORY $JAVA_ARGS -jar Waterfall.jar"
echo "Running Waterfall - $COMMAND"

cd /waterfall
eval $COMMAND
