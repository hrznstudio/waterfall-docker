#!/bin/bash
set -e

WATERFALL_JAR_URL="https://papermc.io/ci/job/Waterfall/lastSuccessfulBuild/artifact/Waterfall-Proxy/bootstrap/target/Waterfall.jar"

SUBSERVERS_ROOT_URL="https://src.me1312.net/jenkins/job/SubServers%20Platform/lastSuccessfulBuild/artifact/Artifacts"
SUBSERVERS_PATCHER_URL="${SUBSERVERS_ROOT_URL}/SubServers.Patcher.sh"
SUBSERVERS_BUNGEE_URL="${SUBSERVERS_ROOT_URL}/SubServers.Bungee.jar"
SUBSERVERS_SYNC_URL="${SUBSERVERS_ROOT_URL}/SubServers.Sync.jar"

cd /waterfall

echo "Fetching Waterfall"
wget -O waterfall.jar "${WATERFALL_JAR_URL}"

if [ ! -z $WATERFALL_CDN_URL ]; then
  echo "Fetching Plugins"
  wget -O plugins.zip "${WATERFALL_CDN_URL}/proxy-plugins.zip"
  unzip plugins.zip -d plugins
  rm -f plugins.zip
  echo "Fetching SubServers keys"
  wget -O SubServers/subdata.rsa.key "${WATERFALL_CDN_URL}/subservers/subdata.rsa.key"
  wget -O SubServers/Cache/private.rsa.key "${WATERFALL_CDN_URL}/subservers/private.rsa.key"
fi

if [ ! -z $WATERFALL_SUBSERVERS_ROLE ]; then
  echo "Fetching SubServers.Patcher"
  wget -O patcher.sh "${SUBSERVERS_PATCHER_URL}"
  chmod +x patcher.sh

  if [[ "${WATERFALL_SUBSERVERS_ROLE}" == "BUNGEE" ]]; then
    echo "Fetching SubServers.Bungee"
    wget -O subservers.jar "${SUBSERVERS_BUNGEE_URL}"
  elif [[ "${WATERFALL_SUBSERVERS_ROLE}" == "SYNC" ]]; then
    echo "Fetching SubServers.Sync"
    wget -O subservers.jar "${SUBSERVERS_SYNC_URL}"
  fi

  apk add git
  sh patcher.sh waterfall.jar subservers.jar | grep -v 'created\|inflated\|adding\|ignoring\|added'
  apk del git
  rm -f patcher.sh waterfall.jar subservers.jar
fi

