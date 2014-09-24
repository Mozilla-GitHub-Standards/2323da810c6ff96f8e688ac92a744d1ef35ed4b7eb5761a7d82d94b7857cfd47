#!/bin/bash

cd $(cd -P -- "$(dirname -- "$0")" && pwd -P)

echo "Install dependencies"
sudo apt-get -qq update
sudo DEBIAN_FRONTEND=noninteractive apt-get -qq -y install openjdk-7-jdk 

echo "Setting up leiningen"
if [ ! -f /usr/local/bin/lein ];
then
	sudo wget -P /usr/local/lein https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
	sudo chmod +x /usr/local/lein
fi
export PATH=$PWD:$PATH

echo "Running detector"
lein run

echo "Submit alerts to medusa"
python python/sender.py
