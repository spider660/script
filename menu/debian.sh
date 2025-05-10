#!/bin/bash
# Quick Setup | Script Setup Manager
# Edition : Stable Edition 1.0
# Auther  : SPILUX TECH
# SPILAU 
# SPILUX 
# fn ki maa ka bhosda 
# (C) Copyright 2023
# =========================================
# pewarna hidup
BGreen='\e[1;32m'
NC='\e[0m'
clear
cd
rm -rf debian.sh
rm -rf /usr/bin/clearcache
rm -rf /usr/bin/menu
echo "\e[1;32m SP1 Update Menu.. \e[0m"
sleep 1
wget -q -O /usr/bin/clearcache https://raw.githubusercontent.com/spider660/script/master/menu/clearcache.sh
wget -q -O /usr/bin/menu https://raw.githubusercontent.com/spider660/script/master/menu/menu.sh
sleep 1
chmod +x /usr/bin/clearcache
chmod +x /usr/bin/menu
clear
rm -rf debian.sh
echo -e "\e[1;32m SPI auto reboot in 5s \e[0m"
sleep 5
reboot
/sbin/reboot


