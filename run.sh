#!/bin/bash
set -e

sed -i "s/{{motd}}/\&1${HOSTNAME}/" /waterfall/config.yml

sed -i "s/{{hostname}}/${HOSTNAME}/" /waterfall/plugins/RedisBungee/config.yml
sed -i "s/{{redis-ip}}/${WATERFALL_REDIS_IP}/" /waterfall/plugins/RedisBungee/config.yml

COMMAND="java -Xmx$JAVA_MEMORY -Xms$JAVA_MEMORY $JAVA_ARGS -jar SubServers.Patched.jar"
echo "Running Waterfall - $COMMAND"

cd /waterfall
eval $COMMAND
