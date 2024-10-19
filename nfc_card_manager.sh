#!/bin/bash

CONFIG_FILE="config.json" # Load config
CARD_DATA_DIR=$(jq -r '.card_data_dir' "$CONFIG_FILE")
LOG_FILE="nfc_project.log"

touch "$LOG_FILE" # Create log file if it doesn't exist

log() { # Logging func
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

list_cards() { # Func to list available cards
  echo "Available saved NFC cards:"
  ls "$CARD_DATA_DIR" | grep card_ || echo "No cards found."
}

read_card() { # Func to read a new NFC card
  echo "Reading NFC card..."
  python3 read_nfc_card.py
}

emulate_card() { # Func to emulate a saved NFC card
  echo "Enter the UID of the card you want to emulate:"
  read card_uid
  card_file="$CARD_DATA_DIR/card_${card_uid}.json"
  if [[ -f "$card_file" ]]; then
    echo "Emulating card with UID: $card_uid"
    ./emulate_nfc_card.sh "$card_uid"
  else
    echo "Card with UID $card_uid not found."
    log "Card with UID $card_uid not found."
    exit 1
  fi
}

show_help() { # Help menu
  echo "NFC Card Manager Help"
  echo "1. Read and Save an NFC Card - Reads an NFC card and saves its data."
  echo "2. List Saved Cards - Displays all saved NFC cards."
  echo "3. Emulate a Saved Card - Emulates a selected NFC card."
  echo "4. Help - Shows this help message."
  echo "5. Exit - Exits the program."
}

while true; do
  echo "NFC Card Manager"
  echo "1. Read and Save an NFC Card"
  echo "2. List Saved Cards"
  echo "3. Emulate a Saved Card"
  echo "4. Help"
  echo "5. Exit"
  
  read -p "Choose an option: " choice
  case $choice in
    1) read_card ;;
    2) list_cards ;;
    3) emulate_card ;;
    4) show_help ;;
    5) exit 0 ;;
    *) echo "Invalid option." ; log "Invalid option selected: $choice" ;;
  esac
done
