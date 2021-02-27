#!/usr/bin/env bash
apt -y update && apt -y dist-upgrade && apt -y autoremove
systemctl stop rsyslog
if [ -f /var/log/wtmp ]; then
    truncate -s0 /var/log/wtmp
fi
if [ -f /var/log/lastlog ]; then
    truncate -s0 /var/log/lastlog
fi
if [ -f /var/log/audit/audit.log ]; then
    truncate -s0 /var/log/audit/audit.log
fi
​
rm -rf /tmp/*
rm -rf /var/tmp/*
rm -rf /etc/ssh/ssh_host_*
dpkg-reconfigure openssh-server
apt clean
cat /dev/null > ~/.bash_history && history -c
history -w
shutdown -r now
