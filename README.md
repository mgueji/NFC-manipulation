# Documentation
> This repo's scripts enables users to **read**, **save**, and **emulate** NFC cards using an Android device equipped with NFC capabilities using Termux. By leveraging **Host Card Emulation (HCE)**, the project facilitates interactions with NFC readers, allowing for various applications such as access control, payment systems, and data sharing.

## How NFC Scanning Works

### NFC Technology
> **NFC (Near Field Communication)** is a set of protocols for communication between devices over short distances (typically 4 cm or less). It operates on the principle of electromagnetic induction, allowing two devices to exchange data when they are brought close together.

### NFC Cards
> NFC cards can store data and communicate with NFC-enabled devices. They often contain an embedded chip that can be read by NFC readers. The cards come in various types, including:

- **NFC Forum Type 1, 2, 3, and 4 Tags**: Standardized formats for NFC data storage.
- **MIFARE Classic**: Commonly used in public transportation and access control systems.
- **NTAG213/215/216**: Popular for marketing and event management due to their NDEF (NFC Data Exchange Format) compatibility.

### Reading NFC Cards
> When the project reads an NFC card, the following steps occur:

1. **Card Detection**: The device emits a radio frequency field, powering the NFC card.
2. **Data Exchange**: The card responds by transmitting its data, such as its UID (Unique Identifier) and any stored NDEF messages.
3. **Data Processing**: The project captures this data using the `nfcpy` library, facilitating communication between the Python script and the NFC card reader.

## How the repo Operates

### System Architecture
> The repo's scripts consists of several components working together:

1. **Termux**: A terminal emulator and Linux environment for Android, allowing users to run command-line scripts and manage files.
2. **Python Script**: The `read_nfc_card.py` script handles the logic for reading NFC cards using the `nfcpy` library.
3. **Bash Scripts**: The main script (`nfc_card_manager.sh`) coordinates user interactions, provides a menu interface, and calls the Python script for reading cards.
4. **Android HCE**: The Android app, configured with an `AndroidManifest.xml`, enables the device to emulate NFC cards.

### Device Interaction
- **NFC Hardware**: Most modern Android devices have NFC hardware that can read and emulate NFC cards. This hardware communicates with the software components to facilitate NFC operations.
- **Root Access**: On rooted devices, additional functionalities and permissions can be granted, enhancing NFC capabilities.

### Device Compatibility

#### Supported Devices
- Android devices with NFC capability and running Android 4.4 (KitKat) or higher can utilize this project.
- Devices that support HCE can effectively emulate NFC cards.

#### Unsupported Devices
- Older Android versions without HCE support.
- Devices without NFC hardware (e.g., certain budget models or older smartphones).
- Some devices may have limited support for specific card types due to hardware or software restrictions.

## Limitations on Cloning

### Reasons Certain Cards Cannot Be Cloned
1. **Security Features**: Many NFC cards implement encryption or security measures to prevent cloning. For example, MIFARE Classic cards use proprietary encryption that cannot be easily bypassed.
2. **Proprietary Protocols**: Some cards use custom protocols that are not supported by standard NFC libraries, limiting their compatibility with open-source tools.
3. **Data Integrity**: Cards that require authentication or have dynamic data (e.g., rolling codes) cannot be accurately cloned, as the data may change with each use.

## Usage Instructions

### Step-by-Step Guide

1. **Setup Termux**:
   - Install Termux from the Google Play Store or F-Droid.
   - Open Termux and configure storage access:
     ```bash
     termux-setup-storage
     ```

2. **Clone the Project**:
   - Download or clone the project repository into your Termux environment.

3. **Install Required Packages**:
   - Ensure that Python and necessary libraries are installed:
     ```bash
     pkg install python
     pip install nfcpy
     pkg install jq
     ```

4. **Configure the Project**:
   - Modify the `config.json` file as needed to set directories and parameters.

5. **Run the Main Script**:
   - Execute the main manager script:
     ```bash
     ./nfc_card_manager.sh
     ```

6. **Reading an NFC Card**:
   - Choose the option to read and save an NFC card. When prompted, hold the card close to the NFC reader.

7. **List Saved Cards**:
   - View saved cards to confirm successful storage.

8. **Emulating a Card**:
   - Select the option to emulate a card, entering the UID of the card to emulate.

9. **Notifications**:
   - Notifications will inform you of the emulation status.

## Security Vulnerabilities

### Potential Risks
1. **Unauthorized Access**: If the device is rooted or improperly secured, unauthorized apps may access stored card data.
2. **Data Privacy**: Sensitive data should be treated with care to prevent exposure.
3. **Legal Implications**: Cloning or emulating cards without permission can lead to legal consequences.

### Mitigation Strategies
- **Device Security**: Use strong authentication methods and keep your device updated.
- **Data Encryption**: Encrypt stored card data to enhance security.
- **Legal Awareness**: Always ensure compliance with local laws regarding NFC card usage.

## Conclusion
> This repo offers a robust solution for reading and emulating NFC cards on Android devices. By understanding how NFC technology works, device compatibility, and security considerations, users can effectively leverage this repo for various applications. Always prioritize security and legal compliance when using NFC technology.
