#!/bin/bash

CARD_DATA_DIR="./card_data"
card_uid="$1"

if [[ -z "$card_uid" ]]; then # Check if UID was passed as an argument
  echo "Usage: emulate_nfc_card.sh <card_uid>"
  exit 1
fi

# Find the saved card file
card_file="$CARD_DATA_DIR/card_${card_uid}.json"
if [[ ! -f "$card_file" ]]; then
  echo "Card with UID $card_uid not found."
  exit 1
fi

am start -n com.example.nfcemulator/.NfcEmulatorService # Start the NFC HCE app (ensure it is installed)

termux-notification --title "NFC Emulation" --content "Card UID: $card_uid is being emulated" --priority high # Notify that emulation is starting

echo "Emulating card with UID: $card_uid" # Output the card data for debugging purposes
cat "$card_file"
termux-toast "Card UID: $card_uid emulated!"
