#!/bin/bash

# Function to fetch RAM information
get_ram_info() {
    ram_info=$(free -m | awk 'NR==2{print $2,$3}')
    tram=$(echo "$ram_info" | awk '{print $1}')
    uram=$(echo "$ram_info" | awk '{print $2}')
}

# Function to fetch CPU usage information
get_cpu_usage() {
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    cpu_usage=$(echo "$cpu_usage" | awk '{printf "%.2f", $1}')
    cpu_usage+=" %"
}

# Function to display VPS information
show_vps_info() {
    clear
    domain=$(cat /etc/xray/domain)
    uptime=$(uptime -p | cut -d " " -f 2-10)
    DATE2=$(date -R | cut -d " " -f -5)
    IPVPS=$(curl -s ifconfig.me)
    LOC=$(curl -sS "https://api.country.is/${IPVPS}" | jq -r '.country')
    if [ -z "$LOC" ]; then
        LOC="Unknown"
    fi

    echo -e "\e[1;33m -------------------------------------------------\e[0m"
    echo -e "\e[1;34m                     Spider VIP SCRIPT                    \e[0m"
    echo -e "\e[1;33m -------------------------------------------------\e[0m"
    echo -e "\e[1;32m OS            \e[0m: $(hostnamectl | grep "Operating System" | cut -d ' ' -f5-)"
    echo -e "\e[1;32m Uptime        \e[0m: $uptime"
    echo -e "\e[1;32m Public IP     \e[0m: $IPVPS"
    echo -e "\e[1;32m Country       \e[0m: $LOC"
    echo -e "\e[1;32m DOMAIN        \e[0m: $domain"
    echo -e "\e[1;32m DATE & TIME   \e[0m: $DATE2"
    echo -e "\e[1;33m -------------------------------------------------\e[0m"
}

# Function to display CPU and RAM information
show_cpu_ram_info() {
    get_ram_info
    get_cpu_usage

    echo -e "\e[1;34m             Spider CPU/RAM INFO                  \e[0m"
    echo -e "\e[1;33m -------------------------------------------------\e[0m"
    echo -e "\e[1;32m CPU USAGE   \e[0m: $cpu_usage"
    echo -e "\e[1;32m RAM USED    \e[0m: ${uram} MB"
    echo -e "\e[1;32m RAM TOTAL   \e[0m: ${tram} MB"
    echo -e "\e[1;33m -------------------------------------------------\e[0m"
}

# Function to display menu and handle user input
show_menu() {
    clear
    show_vps_info
    show_cpu_ram_info

    echo -e "\e[1;34m                      Spider MENU                       \e[0m"
    echo -e "\e[1;33m -------------------------------------------------\e[0m"
    echo -e ""
    echo -e "\e[1;36m 1 \e[0m: Menu Vmess"          "[\e[36m•9\e[0m] : Panel Domain"
    echo -e "\e[1;36m 2 \e[0m: Menu Vmess"          "[\e[36m•10\e[0m] : Set Auto Reboot"
    echo -e "\e[1;36m 3 \e[0m: Menu Trojan"         "[\e[36m•11\e[0m] : Restart All Service"
    echo -e "\e[1;36m 4 \e[0m: Menu Shadowsocks"    "[\e[36m•12\e[0m] : Check Bandwith"
    echo -e "\e[1;36m 5 \e[0m: Speed test"          "[\e[36m•13\e[0m] : Install TCP BBR"
    echo -e "\e[1;36m 6 \e[0m: Status Service"      "[\e[36m•14\e[0m] : DNS CHANGER"
    echo -e "\e[1;36m 7 \e[0m: Clear RAM Cache"
    echo -e "\e[1;36m 8 \e[0m: Reboot VPS"
    echo -e "\e[1;36m x \e[0m: Exit Script"
    echo -e ""
    echo -e "\e[1;33m -------------------------------------------------\e[0m"
    echo -e "\e[1;32m Client Name \e[0m: $Name"
    echo -e "\e[1;32m Expired     \e[0m: $Exp2"
    echo -e "\e[1;32m SCRIPT BY   \e[0m: Spider TECH HUB"
    echo -e "\e[1;32m MADE BY     \e[0m: LAU BUOY"
    echo -e "\e[1;33m -------------------------------------------------\e[0m"
    echo -e ""
    read -p " Select menu :  " opt
    echo ""
    case $opt in
    1) clear ; m-sshovpn ;;
    2) clear ; m-vmess ;;
    3) clear ; m-trojan ;;
    4) clear ; m-ssws ;;
    5) clear ; speedtest ; exit ;;
    6) clear ; running ;;
    7) clear ; clearcache ;;
    8) clear ; /sbin/reboot ;;
    9) clear; m-domain ; exit ;;
    10) clear; auto-reboot ; exit ;;
    11) clear; restart ; exit ;;
    12) clear ; bw ; exit ;; 
    13) clear ; m-tcp ; exit ;;
    14) clear ; m-dns ; exit ;;
    x) exit ;;
    *) echo "Invalid selection" ; sleep 1 ;;
    esac
}

# Initial setup
domain=$(cat /etc/xray/domain)
Exp2="PREMIUM"
Name="Spider TECH"

# Main loop to display menu continuously
while true; do
    show_menu
done
