import nfc
import json
import sys

def write_to_tag(tag, data):
    if tag.ndef:
        tag.ndef.records = [nfc.ndef.TextRecord(data)]
        return True
    else:
        print("Tag does not support NDEF.")
        return False

def main():
    data = input("Enter the data to write to the NFC card: ").strip()
    try:
        with open('config.json') as config_file:
            config = json.load(config_file)
        with nfc.ContactlessFrontend(config['nfc_reader']) as clf:
            print("Place an NFC card near the reader...")
            clf.connect(rdwr={'on-connect': lambda tag: write_to_tag(tag, data)})
    except Exception as e:
        print(f"Error writing to NFC card: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()