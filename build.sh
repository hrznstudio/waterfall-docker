#!/bin/bash
set -e

WATERFALL_JAR_URL="https://papermc.io/ci/job/Waterfall/lastSuccessfulBuild/artifact/Waterfall-Proxy/bootstrap/target/Waterfall.jar"

cd /waterfall

echo "Fetching Waterfall"
wget -O waterfall.jar $WATERFALL_JAR_URL
