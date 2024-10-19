package com.example.nfcemulator;

import android.nfc.cardemulation.HostApduService;
import android.os.Bundle;
import android.util.Log;

public class NfcEmulatorService extends HostApduService {
    private static final String TAG = "NfcEmulatorService";

    @Override
    public void onCreate() {
        super.onCreate();
        Log.d(TAG, "NFC Emulator Service Created");
    }

    @Override
    public byte[] processCommandApdu(byte[] apdu, Bundle extras) {
        Log.d(TAG, "APDU received: " + bytesToHex(apdu));
        // Example response
        return new byte[] { (byte) 0x90, 0x00 }; // Success
    }

    @Override
    public void onDeactivated(int reason) {
        Log.d(TAG, "NFC Emulator Service Deactivated: " + reason);
    }

    private String bytesToHex(byte[] bytes) {
        StringBuilder hexString = new StringBuilder();
        for (byte b : bytes) {
            hexString.append(String.format("%02X", b));
        }
        return hexString.toString();
    }
}
