# Documentation

> This directory contains saved NFC card data in JSON format.

## File Format
- Each file is named `card_<UID>.json`.
- The JSON structure includes:
  - `UID`: The unique identifier of the NFC card.
  - `Card Type`: Type information of the NFC card.
  - `NDEF Message`: The message stored on the card, if applicable.

## Usage
1. Use the `nfc_card_manager.sh` script to manage NFC cards.
2. Read an NFC card to save its data.
3. List saved cards or emulate a specific card.
