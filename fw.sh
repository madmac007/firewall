#!/bin/sh
#
# Centos 6.5
# Modified by Dave M
# techyguru.com
# Jan 31 2014
## Set your IP address
MYIP="xxx.xxx.xxx.xxx"
iptables -A INPUT -i eth0 -f -j DROP
iptables -A INPUT -s 127.0.0.0/8 ! -i lo -j DROP
iptables  -A INPUT -s 224.0.0.0/4 ! -i lo -j DROP
iptables -A INPUT -s 0.0.0.0/8 ! -i lo -j DROP
iptables -A INPUT -s 255.255.255.255/32 ! -i lo -j DROP
iptables -A INPUT -s 169.254.0.0/16 ! -i lo -j DROP
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT
iptables -A INPUT -s $MYIP -i lo -j DROP
iptables -A INPUT -p tcp -m tcp --dport 22 --tcp-flags FIN,SYN,RST,ACK SYN -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 25 --tcp-flags FIN,SYN,RST,ACK SYN -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 80 --tcp-flags FIN,SYN,RST,ACK SYN -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 110 --tcp-flags FIN,SYN,RST,ACK SYN -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 113 --tcp-flags FIN,SYN,RST,ACK SYN -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 143 --tcp-flags FIN,SYN,RST,ACK SYN -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 443 --tcp-flags FIN,SYN,RST,ACK SYN -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 465 --tcp-flags FIN,SYN,RST,ACK SYN -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 587 --tcp-flags FIN,SYN,RST,ACK SYN -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 993 --tcp-flags FIN,SYN,RST,ACK SYN -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 995 --tcp-flags FIN,SYN,RST,ACK SYN -j ACCEPT
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -m state --state NEW -j REJECT --reject-with icmp-port-unreachable
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A OUTPUT -p tcp -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p udp -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p icmp -m state --state NEW,RELATED,ESTABLISHED -j ACCEPT
service iptables save
#
#
echo "iptables configuration is complete"
echo ""
echo "Check your rules - iptables -L -n"
echo ""

