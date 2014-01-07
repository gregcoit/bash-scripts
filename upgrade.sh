#!/bin/bash
#
# Upgrade a node
#
 
cassandra_config="/etc/cassandra/cassandra.yaml"
 
echo "Taking snapshot..."
nodetool -h localhost snapshot
 
echo "Stopping Cassandra..."
monit stop cassandra
 
while [ $(ps -ef | grep jsvc | wc -l) -gt 1 ]; do
  echo "Waiting for Cassandra to stop..."
  sleep 5
done
 
echo "Downloading and installing Cassandra 1.1..."
wget "https://archive.apache.org/dist/cassandra/debian/pool/main/c/cassandra/cassandra_1.1.10_all.deb"
dpkg --force-confold -i cassandra_1.1.10_all.deb
 
echo "Starting Cassandra..."
monit restart cassandra
