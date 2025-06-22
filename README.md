# Deauth_Attack

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
