# 🛠️ Wi-Fi Deauth Tool (Bash Script)

This is a **menu-driven Bash tool** designed for performing Wi-Fi Deauthentication attacks using `aircrack-ng` tools on Kali Linux. It includes safe Ctrl+C handling and simplifies actions like scanning networks, testing injection, and targeting specific clients.

> ⚠️ For **educational purposes only**. Unauthorized use on networks you do not own or have permission to test is **illegal**.

---

## 📦 Features

- View available Wi-Fi interfaces
- Kill conflicting processes
- Start/Stop monitor mode
- Scan nearby Wi-Fi networks
- Test AP for injection support
- Scan clients connected to a specific router
- Deauth a specific client
- Cleanly handles Ctrl+C without exiting the tool

---

## 🧰 Requirements

- Kali Linux (or any Linux with `aircrack-ng`)
- `airmon-ng`, `airodump-ng`, `aireplay-ng` installed (part of `aircrack-ng`)
- Root privileges

---

## 🚀 Installation & Usage

1. **Download the script** and make it executable:
   ```bash
   chmod +x deauth.sh
2. Run the script as root:
sudo ./deauth.sh

##📋 Menu Options

Option	  Description
1	Show available Wi-Fi interfaces (iwconfig)

2	Kill services that interfere with monitor mode

3	Start monitor mode on selected interface

4	Scan nearby Wi-Fi networks using airodump-ng

5	Test if AP supports injection (aireplay-ng --test)

6	Scan clients connected to a specific router (BSSID & channel needed)

7	Perform a deauth attack on a selected client

8	Stop monitor mode and restart networking

9	Exit the tool

## 🛑 Ctrl+C Handling

    Pressing Ctrl+C during scanning or attacks doesn't exit the script.

    It gracefully stops the current action and returns to the main menu.

## ⚠️ Legal Disclaimer

This script is intended only for educational and authorized security testing purposes. Unauthorized scanning, monitoring, or attacking of networks is illegal and unethical.
