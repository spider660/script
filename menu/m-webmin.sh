#!/bin/bash
MYIP=$(wget -qO- ipv4.icanhazip.com);
echo "Checking VPS"
clear
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[Installed]${Font_color_suffix}"
Error="${Red_font_prefix}[Not Installed]${Font_color_suffix}"
cek=$(netstat -ntlp | grep 10000 | awk '{print $7}' | cut -d'/' -f2)
function install () {
IP=$(wget -qO- ifconfig.me/ip);
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[0;100;33m        • SPILUX INSTALL WEBMIN •         \E[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 0.5
echo ""
echo -e "\033[32m[Info]\033[0m Adding Repository of NT Webmin"
sh -c 'echo "deb http://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webmin.list'
apt install gnupg gnupg1 gnupg2 -y > /dev/null 2>&1
wget http://www.webmin.com/jcameron-key.asc > /dev/null 2>&1
apt-key add jcameron-key.asc > /dev/null 2>&1
sleep 0.5
echo -e "\033[32m[Info]\033[0m Start Install NT Webmin"
sleep 0.5
apt update > /dev/null 2>&1
apt install webmin -y > /dev/null 2>&1
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
echo -e "\033[32m[Info]\033[0m Restart NT Webmin"
/etc/init.d/webmin restart > /dev/null 2>&1
rm -f /root/jcameron-key.asc > /dev/null 2>&1
sleep 0.5
echo -e "\033[32m[Info]\033[0m NT Webmin Install Successfully !"
echo ""
echo " $IP:10000"
echo ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on NTmenu"
m-webmin
}
function restart () {
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[0;100;33m        • NT RESTART WEBMIN •         \E[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 0.5
echo ""
echo " Restarting NT Webmin"
service webmin restart > /dev/null 2>&1
echo ""
sleep 0.5
echo -e "\033[32m[Info]\033[0m NT Webmin Start Successfully !"
echo ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on NT menu"
m-webmin
}
function uninstall () {
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[0;100;33m       • UNINSTALL NT WEBMIN •        \E[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 0.5
echo ""
echo -e "\033[32m[Info]\033[0m Removing NT Webmin Repository"
rm -f /etc/apt/sources.list.d/webmin.list
apt update > /dev/null 2>&1
sleep 0.5
echo -e "\033[32m[Info]\033[0m Start Uninstall Webmin"
apt autoremove --purge webmin -y > /dev/null 2>&1
sleep 0.5
echo -e "\033[32m[Info]\033[0m NT Webmin Uninstall Successfully !"
echo ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on NT menu"
m-webmin
}
if [[ "$cek" = "perl" ]]; then
sts="${Info}"
else
sts="${Error}"
fi
clear 
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[0;100;33m          • NT WEBMIN MENU •          \E[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e " Status $sts"
echo -e " [\e[36m•1\e[0m] Install NT Webmin"
echo -e " [\e[36m•2\e[0m] Restart NT Webmin"
echo -e " [\e[36m•3\e[0m] Uninstall NT Webmin"
echo -e ""
echo -e " [\e[31m•0\e[0m] \e[31mBACK TO NT MENU\033[0m"
echo -e ""
echo -e   "Press x or [ Ctrl+C ] • To-Exit"
echo -e ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -rp " Please Enter The Correct Number : " -e num
if [[ "$num" = "1" ]]; then
install
elif [[ "$num" = "2" ]]; then
restart
elif [[ "$num" = "3" ]]; then
uninstall
elif [[ "$num" = "0" ]]; then
menu
elif [[ "$num" = "x" ]]; then
exit
else
clear
echo " You Entered The Wrong Number"
sleep 2
m-webmin
fi
