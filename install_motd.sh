#!/bin/bash

echo "" | sudo tee /etc/motd

if [ -f "/etc/ssh/sshd_config" ]; then
    sudo sed -i 's/^PrintMotd .*//g' /etc/ssh/sshd_config
    sudo sed -i 's/^PrintLastLog .*//g' /etc/ssh/sshd_config

    echo "PrintMotd no" | sudo tee -a /etc/ssh/sshd_config
    echo "PrintLastLog no" | sudo tee -a /etc/ssh/sshd_config

    sudo service ssh restart
fi

if [ -f "/etc/init.d/motd" ]; then
    sudo sed -i '/uname/ s/^/#/' /etc/init.d/motd
    sudo rm -f /run/motd.dynamic
fi

if [ ! -f "/etc/motd.dynamic" ]; then
    sudo cp ./motd /etc/motd.dynamic
    sudo chmod +x /etc/motd.dynamic
    echo "source /etc/motd.dynamic" | sudo tee -a ~/.profile
fi

echo "RaspberryPi-MOTD - successfully installed!"
