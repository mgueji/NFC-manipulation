#!/bin/bash

CARD_DATA_DIR="./card_data"
card_uid="$1"

# Check if UID was passed as an argument
if [[ -z "$card_uid" ]]; then
  echo "Usage: emulate_nfc_card.sh <card_uid>"
  exit 1
fi

# Find the saved card file
card_file="$CARD_DATA_DIR/card_${card_uid}.json"
if [[ ! -f "$card_file" ]]; then
  echo "Card with UID $card_uid not found."
  exit 1
fi

# Start the NFC HCE app (ensure it is installed)
if ! am start -n com.example.nfcemulator/.NfcEmulatorService; then
  echo "Failed to start the NFC emulator service."
  exit 1
fi

# Notify that emulation is starting
termux-notification --title "NFC Emulation" --content "Card UID: $card_uid is being emulated" --priority high

# Output card data for debugging purposes
echo "Emulating card with UID: $card_uid"
cat "$card_file"
termux-toast "Card UID: $card_uid emulated!"
