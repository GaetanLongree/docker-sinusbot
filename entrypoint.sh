#!/bin/bash

###### Update process ######
# TODO test if already installed
# TODO install Discord client as well

#Downloading TeamSpeak3 Client linux
wget http://dl.4players.de/ts/releases/3.1.9/TeamSpeak3-Client-linux_amd64-3.1.9.run -P /sinusbot
chmod +x /sinusbot/TeamSpeak3-Client-linux_amd64-3.1.9.run
# TODO fix user prompt
/sinusbot/TeamSpeak3-Client-linux_amd64-3.1.9.run
rm TeamSpeak3-Client-linux_amd64-3.1.9.run

#Downloading new version of sinusbot
wget https://www.sinusbot.com/dl/sinusbot.current.tar.bz2 -P /tmp
#Extracting and overwriting files
tar -xjf /tmp/sinusbot.current.tar.bz2 -C /sinusbot
#Moving plugin to Teamspeak client
cp /sinusbot/plugin/libsoundbot_plugin.so /sinusbot/TeamSpeak3-Client-linux_amd64/plugins
#Cleaning up
rm /tmp/sinusbot.current.tar.bz2

###### Starting sinusbot ######
#Moving old log
# TODO check is folder exists
mkdir /sinusbot/logs_archive
mv /sinusbot/sinusbot.log /sinusbot/logs_archive/sinusbot_$(date +%F-%T).log
#Creating new log file
touch /sinusbot/sinusbot.log

# TODO test is config.ini is present before overwriting
cat > /sinusbot/config.ini << EOF
TS3Path = "/sinusbot/TeamSpeak3-Client-linux_amd64/ts3client_linux_amd64"
ListenHost = "0.0.0.0"
DataDir = "/music"
ListenPort = 8080
YoutubeDLPath = "/usr/local/bin/youtube-dl"
EOF

#Executing sinusbot command and redirecting outputs to log file
#/sinusbot/sinusbot &>> /sinusbot/sinusbot.log
# TODO fixe X server sanity check
/sinusbot/sinusbot
