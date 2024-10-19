import nfc
import os
import json
import sys

# Load config
with open('config.json') as config_file:
    config = json.load(config_file)

CARD_DATA_DIR = config['card_data_dir']
os.makedirs(CARD_DATA_DIR, exist_ok=True)

def on_connect(tag):
    uid = tag.identifier.hex()
    card_data = {
        "UID": uid,
        "Card Type": str(tag),
        "NDEF Message": tag.ndef.message if tag.ndef else "No NDEF data found."
    }
    
    card_file = os.path.join(CARD_DATA_DIR, f"card_{uid}.json")
    with open(card_file, "w") as f:
        json.dump(card_data, f, indent=4)
    
    print(f"Card data saved to {card_file}")

def main():
    try:
        with nfc.ContactlessFrontend(config['nfc_reader']) as clf:
            print("Place an NFC card near the reader...")
            clf.connect(rdwr={'on-connect': on_connect})
    except Exception as e:
        print(f"Error reading NFC card: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
