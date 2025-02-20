#!/bin/bash

CONFIG_FILE="config.json" # Load config
CARD_DATA_DIR=$(jq -r '.card_data_dir' "$CONFIG_FILE")
LOG_FILE="nfc_project.log"

# Create a log file if it doesn't exist
touch "$LOG_FILE"

log() { # Logging
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

list_cards() { # Func to list available cards
  echo "Available saved NFC cards:"
  ls "$CARD_DATA_DIR" | grep card_ || echo "No cards found."
}

read_card() { # Func to read a new NFC card
  echo "Reading NFC card..."
  if python3 read_nfc_card.py; then
    log "Successfully read and saved NFC card."
  else
    log "Error reading NFC card."
  fi
}

write_card() { # Func to write data to an NFC card
  echo "Writing NFC card..."
  if python3 write_nfc_card.py; then
    log "Successfully wrote data to NFC card."
  else
    log "Error writting to NFC card."
  fi
}

emulate_card() { # Func to emulate a saved NFC card
  read -p "Enter the UID of the card to emulate: " card_uid
  card_file="$CARD_DATA_DIR/card_${card_uid}.json"
  
  if [[ -f "$card_file" ]]; then
    echo "Emulating card with UID: $card_uid"
    ./emulate_nfc_card.sh "$card_uid"
  else
    echo "Card with UID $card_uid not found."
    log "Attempted to emulate non-existent card UID: $card_uid."
  fi
}

show_help() { # Help func
  echo "NFC Card Manager Help"
  echo "1. Read and Save an NFC Card - Reads an NFC card and saves its data."
  echo "2. Write data to an NFC Card - Writes data to an NFC card."
  echo "3. List Saved Cards - Displays all saved NFC cards."
  echo "4. Emulate a Saved Card - Emulates a selected NFC card."
  echo "5. Help - Shows this help message."
  echo "6. Exit - Exits the program."
}

while true; do
  echo "NFC Card Manager"
  echo "1. Read and Save an NFC Card"
  echo "2. Write Data to an NFC Card"
  echo "3. List Saved Cards"
  echo "4. Emulate a Saved Card"
  echo "5. Help"
  echo "6. Exit"
  
  read -p "Choose an option: " choice
  case $choice in
    1) read_card ;;
    2) write_card ;;
    3) list_cards ;;
    4) emulate_card ;;
    5) show_help ;;
    6) exit 0 ;;
    *) echo "Invalid option. Please try again." ; log "Invalid option selected: $choice." ;;
  esac
done
