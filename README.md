# BashBunny Payloads

This repository contains a set of payloads designed for the [Hak5 BashBunny](https://shop.hak5.org/products/bash-bunny).  
Each payload targets different use cases related to credential capture or deploying PowerBeacon modules.

---

## Payloads

### LsassAttack
**Description:**  
`LsassAttack` is a payload for credential capturing on Windows targets.  
It supports two primary methods:
- **Invoke-Mimikatz.ps1**: Extracts credentials directly from memory.  
- **procdump64.exe**: Dumps the `lsass.exe` process for offline analysis.  

**Notes:**  
- Windows Defender and LSASS process protection may interfere with this payload.  
- Administrator privileges are typically required.  

---

### PowerBeaconMenu
**Description:**  
`PowerBeaconMenu` provides a menu-driven interface for managing PowerBeacon payloads directly from the BashBunny.  

It includes placeholders for:
- Validate
- Install
- Uninstall

Replace these with your own PowerBeacon payloads, then copy everything into the BashBunny’s `payloads` directory for the desired switch position.

---

### PowerBeaconSingle
**Description:**  
`PowerBeaconSingle` is a lightweight payload to perform a single PowerBeacon install or uninstall action, without using the menu-driven interface.

---

## Usage
1. Copy the desired payload directory to the BashBunny `payloads` folder.  
2. Safely eject the BashBunny and switch to the corresponding position.  
3. Deploy against your target system.  

---

## Disclaimer
These payloads are provided for educational and authorized testing purposes only.  
Do not use them on systems you do not own or have explicit permission to test.  
The author assumes no liability for misuse or damages caused.
